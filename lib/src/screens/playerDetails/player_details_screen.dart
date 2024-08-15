import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:truck/assets/fonts/MavicIcons/mavic_i_cons_icons.dart';
import 'package:truck/src/bloc/fixtures/fixtures.bloc.dart';
import 'package:truck/src/bloc/fixtures/fixtures_events.dart';
import 'package:truck/src/bloc/player/player.bloc.dart';
import 'package:truck/src/bloc/player/player_events.dart';
import 'package:truck/src/models/api_response_model.dart';
import 'package:truck/src/models/players_model.dart';
import 'package:truck/src/screens/matchDetails/pageviews/details_page_screen.dart';
import 'package:truck/src/screens/matchDetails/pageviews/head_to_head_screen.dart';
import 'package:truck/src/screens/matchDetails/pageviews/lineup_screen.dart';
import 'package:truck/src/screens/matchDetails/pageviews/stats_screen.dart';

class PlayerDetailsScreen extends StatefulWidget {
  final int playerId;

  const PlayerDetailsScreen({Key? key, required this.playerId})
      : super(key: key);

  @override
  _PlayerDetailsScreenState createState() => _PlayerDetailsScreenState();
}

class _PlayerDetailsScreenState extends State<PlayerDetailsScreen>
    with SingleTickerProviderStateMixin {
  late PlayerBloc _playerBloc;

  late ScrollController _scrollController;
  late TabController _tabController;

  late PlayerResponse _playerResponse;

  static const double collapsedBarHeight = 60.0;
  static const double expandedBarHeight = 320.0;
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

  final List<String> pageViewNavs = ["Overview", "Lineup", "Stats", "H2H"];

  @override
  void initState() {
    super.initState();
    _playerBloc = PlayerBloc();
    _playerBloc.add(FetchPlayer(widget.playerId));
    _tabController = TabController(vsync: this, length: pageViewNavs.length);
    _scrollController = ScrollController()..addListener(_onScroll);
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

    _tabController.dispose();
    super.dispose();
  }

  List<Widget> _buildPageNav() {
    return pageViewNavs.map((nav) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
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

  Widget _buildAppBar(PlayerResponse playerResponse) {
    return SliverAppBar(
      expandedHeight: expandedBarHeight,
      pinned: true,
      surfaceTintColor: Colors.transparent,
      collapsedHeight: collapsedBarHeight,
      actionsIconTheme: IconThemeData(
        opacity: _textOpacity,
      ),
      flexibleSpace: Container(
        height: expandedBarHeight,
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
        ),
        child: playerResponse.responseData.isNotEmpty
            ? Container(
              margin: const EdgeInsets.only(top: 100.0,left: 20 ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Player Details
                    Container(),
              
                    //Player Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        child: Image.network(playerResponse.responseData[0].player.photo!,),
                      ),
                    )
                    ],
                ),
            )
            : Center(
                child: Text(
                  'Could not retrieve player Details',
                  style: TextStyle(fontSize: 34),
                ),
              ),
      ),
      actions: _buildAppBarActions(),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: TabBar(
          onTap: (value) => _tabController.animateTo(value),
          controller: _tabController,
          tabAlignment: TabAlignment.start,
          dividerColor: Colors.transparent,
          isScrollable: true,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            color: Theme.of(context).primaryColor.withOpacity(.3),
          ),
          tabs: _buildPageNav(),
        ),
      ),
    );
  }

  List<Widget> _buildAppBarActions() {
    return [
      IconButton(onPressed: () {}, icon: Icon(MavicICons.share_ios_export)),
      IconButton(onPressed: () {}, icon: Icon(MavicICons.bell_notification)),
      IconButton(onPressed: () {}, icon: Icon(MavicICons.star)),
    ];
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PlayerBloc, PlayerState>(
          bloc: _playerBloc,
          builder: (context, state) {
            if (state is PlayerLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is PlayerLoaded) {
              return NestedScrollView(
                  controller: _scrollController,
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      _buildAppBar(state.response),
                    ];
                  },
                  body: Container());
            } else if (state is PlayerError) {
              return Center(child: Text(state.message));
            }
            return Container();
          }),
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
