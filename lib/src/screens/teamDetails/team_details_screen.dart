import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:truck/assets/fonts/MavicIcons/mavic_i_cons_icons.dart';
import 'package:truck/src/bloc/player/player_events.dart';
import 'package:truck/src/bloc/team/team.bloc.dart';
import 'package:truck/src/bloc/team/team_events.dart';
import 'package:truck/src/models/team_response_model.dart';
import 'package:truck/src/screens/teamDetails/pageview/overviewPage.dart';
import 'package:truck/src/themes/dartk_theme.dart';

class TeamDetailsScreen extends StatefulWidget {
  final int teamId;

  const TeamDetailsScreen({super.key, required this.teamId});

  @override
  _TeamDetailsScreenState createState() => _TeamDetailsScreenState();
}

class _TeamDetailsScreenState extends State<TeamDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TeamBloc _teamBloc;

  late ScrollController _scrollController;
  late TabController _tabController;

  static const double collapsedBarHeight = 60.0;
  static const double expandedBarHeight = 350.0;
  static const double maxOffset = expandedBarHeight - 150;

  bool isExpanded = true;
  double _textOpacity = 1.0;
  double _titlePaddingVertical = 70;
  double _titlePaddingHorizontal = 0;

  double _backdropBottom = 10;
  double _scrollOffset = 0;

  Color interpolatedColor = Colors.transparent;

  final List<String> pageViewNavs = ["Overview"];

  @override
  void initState() {
    super.initState();
    _teamBloc = TeamBloc();
    _teamBloc.add(FetchTeamDetails(widget.teamId));
    _tabController = TabController(vsync: this, length: pageViewNavs.length);
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  void _onScroll() {
    double offset = _scrollController.offset;
    setState(() {
      _scrollOffset = offset;
      _textOpacity = ((maxOffset - offset) / maxOffset).clamp(0.0, 1.0);
      _backdropBottom =
          ((maxOffset - offset) / maxOffset * 90).clamp(0.0, 10.0);

      _titlePaddingHorizontal =
          ((maxOffset - offset) / maxOffset).clamp(10, 40);
      _titlePaddingVertical =
          ((maxOffset - offset) / maxOffset * 90).clamp(10, 70);

      double factor = (_scrollOffset / maxOffset).clamp(0.0, 1.0);

      Color startColor = Colors.transparent;
      Color endColor = Theme.of(context).canvasColor;

      // Interpolate between the start and end colors
      interpolatedColor = Color.lerp(endColor, startColor, factor)!;
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
        decoration: const BoxDecoration(
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

  Widget _buildAppBar(TeamDetailsResponse teamDetailsResponse) {
    return SliverAppBar(
      expandedHeight: expandedBarHeight,
      pinned: true,
      surfaceTintColor: Colors.transparent,
      actionsIconTheme: IconThemeData(
        opacity: _textOpacity,
      ),
      flexibleSpace: teamDetailsResponse.responseData.isNotEmpty
          ? FlexibleSpaceBar(
              titlePadding:
                  EdgeInsets.symmetric(vertical: _titlePaddingVertical),
              title: Container(
                height: 100,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Row(
                  children: [
                    Opacity(
                      opacity: _textOpacity,
                      child: Image.network(
                        teamDetailsResponse.responseData[0].team.logo!,
                        width: 70,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            teamDetailsResponse.responseData[0].team.name!,
                            //textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontFamily: 'NunitoSans',
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Opacity(
                            opacity: _textOpacity,
                            child: Text(
                              teamDetailsResponse.responseData[0].team.country!,
                              style: const TextStyle(
                                  fontFamily: 'NunitoSans',
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              background: Container(
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(teamDetailsResponse
                                  .responseData[0].venue.image!),
                              fit: BoxFit.fill)),
                    ),
                    Container(
                      color: Theme.of(context).canvasColor.withOpacity(.5),
                    )
                  ],
                ),
              ),
            )
          : Container(),
      actions: _buildAppBarActions(),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: TabBar(
          onTap: (value) => _tabController.animateTo(value),
          controller: _tabController,
          tabAlignment: TabAlignment.start,
          dividerColor: Colors.transparent,
          isScrollable: true,
          indicator: BoxDecoration(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
            color: Theme.of(context).primaryColor.withOpacity(.3),
          ),
          tabs: _buildPageNav(),
        ),
      ),
    );
  }

  List<Widget> _buildAppBarActions() {
    return [
      IconButton(
          onPressed: () {}, icon: const Icon(MavicICons.share_ios_export)),
      IconButton(
          onPressed: () {}, icon: const Icon(MavicICons.bell_notification)),
      IconButton(onPressed: () {}, icon: const Icon(MavicICons.star)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TeamBloc, TeamState>(
          bloc: _teamBloc,
          builder: (context, state) {
            if (state is TeamLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TeamLoaded) {
              return NestedScrollView(
                controller: _scrollController,
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    _buildAppBar(state.response),
                  ];
                },
                body: TabBarView(
                    controller: _tabController, children: [
                      OverViewPage(
                      teamDetailsResponse: state.response ,
                    )]),
              );
            } else if (state is TeamError) {
              return Center(child: Text(state.message));
            }
            return Container();
          }),
    );
  }
}
