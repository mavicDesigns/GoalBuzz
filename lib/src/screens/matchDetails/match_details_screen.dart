import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:truck/assets/fonts/MavicIcons/mavic_i_cons_icons.dart';
import 'package:truck/src/bloc/fixtures/fixtures.bloc.dart';
import 'package:truck/src/bloc/fixtures/fixtures_events.dart';
import 'package:truck/src/models/api_response_model.dart';
import 'package:truck/src/screens/matchDetails/pageviews/details_page_screen.dart';
import 'package:truck/src/screens/matchDetails/pageviews/head_to_head_screen.dart';
import 'package:truck/src/screens/matchDetails/pageviews/lineup_screen.dart';
import 'package:truck/src/screens/matchDetails/pageviews/stats_screen.dart';

class MatchDetailsScreen extends StatefulWidget {
  final Data response;

  const MatchDetailsScreen({Key? key, required this.response})
      : super(key: key);

  @override
  _MatchDetailsScreenState createState() => _MatchDetailsScreenState();
}

class _MatchDetailsScreenState extends State<MatchDetailsScreen>
    with SingleTickerProviderStateMixin {
  late FixturesBloc _fixturesBloc;

  late Timer? _timer;
  late Duration _duration;
  bool _showCountdown = true;

  late ScrollController _scrollController;
  late TabController _tabController;

  static const double collapsedBarHeight = 60.0;
  static const double expandedBarHeight = 200.0;
  static const double maxOffset = expandedBarHeight - 150;
  static const double initialTranslateX = 0;
  static const double finalTranslateX = 70;

  bool isExpanded = true;
  double _textOpacity = 1.0;
  double _imageScale = 1.0;
  double _translateX = 0;
  double _imageBoxMargin = 90;
  double _scoreBoxMargin = 60;
  double _scrollOffset = 0;

  final List<String> pageViewNavs = ["Details", "Lineup", "Stats", "H2H"];

  @override
  void initState() {
    super.initState();
    _fixturesBloc = FixturesBloc();
    _fixturesBloc.add(FetchFixture(widget.response.fixture!.id!));
    _tabController = TabController(vsync: this, length: pageViewNavs.length);
    _scrollController = ScrollController()..addListener(_onScroll);

    final now = DateTime.now();
    final targetTime = widget.response.fixture!.date!;

    // Calculate the initial duration
    _duration = targetTime.difference(now);
    _startCountdown();

    // If the time is in the past, remove the widget
    if (_duration.isNegative) {
      _timer!.cancel();
      setState(() {
        _showCountdown = false;
      });
    }
  }

  void _onScroll() {
    double offset = _scrollController.offset;
    setState(() {
      _scrollOffset = offset;
      _textOpacity = ((maxOffset - offset) / maxOffset).clamp(0.0, 1.0);
      _imageBoxMargin =
          ((maxOffset - offset) / maxOffset * 90).clamp(0.0, 90.0);
      _scoreBoxMargin =
          ((maxOffset - offset) / maxOffset * 60).clamp(0.0, 60.0);
      _imageScale = ((maxOffset - offset) / maxOffset).clamp(0.5, 1.0);
      _translateX = (initialTranslateX +
              (offset / maxOffset) * (finalTranslateX - initialTranslateX))
          .clamp(initialTranslateX, finalTranslateX);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    if (_timer != null) {
  _timer!.cancel();
}

    _tabController.dispose();
    super.dispose();
  }

  List<Widget> _buildPageNav() {
    return pageViewNavs.map((nav) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border:
              Border.all(color: Theme.of(context).primaryColor.withOpacity(.4)),
        ),
        child: Text(
          nav,
          style: TextStyle(
            fontSize: 12,
            fontFamily: Theme.of(context).textTheme.bodyLarge!.fontFamily,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.bodySmall!.color!,
          ),
        ),
      );
    }).toList();
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: expandedBarHeight,
      pinned: true,
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      collapsedHeight: collapsedBarHeight,
      actionsIconTheme: IconThemeData(
        opacity: _textOpacity,
      ),
      flexibleSpace: Stack(
        children: [
          ClipPath(
            clipper: BottomCurveClipper(_scrollOffset),
            child: Container(
              height: expandedBarHeight,
              decoration: BoxDecoration(
                color: Theme.of(context).cardTheme.color,
                boxShadow: [BoxShadow()],
              ),
            ),
          ),
          _buildFinishedScoreBar(),
        ],
      ),
      actions: _buildAppBarActions(),
      bottom:
          PreferredSize(preferredSize: Size.fromHeight(40), child: Container()),
    );
  }

  List<Widget> _buildAppBarActions() {
    return [
      IconButton(onPressed: () {}, icon: Icon(MavicICons.share_ios_export)),
      IconButton(onPressed: () {}, icon: Icon(MavicICons.bell_notification)),
      IconButton(onPressed: () {}, icon: Icon(MavicICons.star)),
    ];
  }

  Widget _buildFinishedScoreBar() {
    return AnimatedBuilder(
      animation: _scrollController,
      builder: (context, child) {
        return Align(
          alignment: Alignment.center,
          child: Row(
            children: [
              _buildTeamColumn(
                  widget.response.teams!.home['logo'],
                  widget.response.teams!.home['name'],
                  _translateX,
                  _imageBoxMargin,
                  Alignment.centerRight),
              widget.response.fixture!.status!.elapsed != null
                  ? _buildScoreColumn()
                  : _buildTimeColumn(),
              _buildTeamColumn(
                  widget.response.teams!.away['logo'],
                  widget.response.teams!.away['name'],
                  -_translateX,
                  _imageBoxMargin,
                  Alignment.centerLeft),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTeamColumn(String imagePath, String teamName, double translateX,
      double margin, Alignment alignment) {
    return Expanded(
      flex: 2,
      child: Transform.translate(
        offset: Offset(translateX, 0),
        child: Transform.scale(
          scale: _imageScale,
          child: Align(
            alignment: alignment,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: margin),
                Image.network(imagePath, width: 75),
                SizedBox(height: 10),
                Opacity(
                  opacity: _textOpacity,
                  child: Text(
                    teamName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.displayLarge!.color,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _startCountdown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_duration.inSeconds > 0) {
          _duration = _duration - Duration(seconds: 1);
        } else {
          _timer?.cancel();
          _showCountdown = false;
        }
      });
    });
  }

  Widget _buildTimeColumn() {
    final Fixture? fixture = widget.response.fixture;

    final hours = _duration.inHours.toString().padLeft(2, '0');
    final minutes = (_duration.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (_duration.inSeconds % 60).toString().padLeft(2, '0');

    return Expanded(
      flex: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: _scoreBoxMargin),
          Text(''),
          Transform.scale(
            scale: _imageScale,
            child: Text(
              DateFormat('hh:mm').format(fixture!.date!),
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.displayLarge!.color,
              ),
            ),
          ),
          Opacity(
            opacity: _textOpacity,
            child: Text(
              "$hours:$minutes:$seconds",
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyLarge!.color),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreColumn() {
    final Score? score = widget.response.score;
    final TeamsClass goals = widget.response.goals!;
    final Fixture? fixture = widget.response.fixture;

    return Expanded(
      flex: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: _scoreBoxMargin),
          Text(''),
          Transform.scale(
            scale: _imageScale,
            child: Text(
              '${goals.home.toString()} - ${goals.away.toString()}',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.displayLarge!.color,
              ),
            ),
          ),
          Opacity(
            opacity: _textOpacity,
            child: Text(
              fixture!.status!.short!,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyLarge!.color),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            _buildAppBar(),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TabBar(
                  onTap: (value) => _tabController.animateTo(value),
                  controller: _tabController,
                  dividerColor: Colors.transparent,
                  isScrollable: true,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).primaryColor,
                    border: Border.all(
                        color: Theme.of(context).primaryColor.withOpacity(.4)),
                  ),
                  tabs: _buildPageNav(),
                ),
              ),
            ),
          ];
        },
        body: TabBarView(controller: _tabController, children: [
          DetailsPageView(
            response: widget.response,
          ),
          LineUpPageView(response: widget.response),
          StatsPageView(
            response: widget.response,
          ),
          HeadToHeadPageView(
            response: widget.response,
          ),
        ]),
      ),
    );
  }
}

class BottomCurveClipper extends CustomClipper<Path> {
  final double scrollOffset;

  BottomCurveClipper(this.scrollOffset);

  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 40);

    double normalizedOffset = min(scrollOffset, 170.0);
    double controlPointY = size.height + (20 - (normalizedOffset / 3));

    path.quadraticBezierTo(
      size.width / 2,
      controlPointY,
      size.width,
      size.height - 40,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
