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
import 'package:truck/src/screens/playerDetails/pageview/overviewPage.dart';
import 'package:truck/src/screens/playerDetails/pageview/statisticsPage.dart';

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
  static const double expandedBarHeight = 350.0;
  static const double maxOffset = expandedBarHeight - 150;
  static const double initialTranslateX = 0;
  static const double finalTranslateX = 70;

  bool isExpanded = true;
  double _textOpacity = 1.0;
  double _imageScale = 1.0;
  double _translateX = 0;
  double _backdropBottom = 10;
  double _scrollOffset = 0;

  Color interpolatedColor = Colors.transparent;

  final List<String> pageViewNavs = ["Overview", "Stats", "Career"];

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
      _backdropBottom =
          ((maxOffset - offset) / maxOffset * 90).clamp(0.0, 10.0);

      _imageScale = ((maxOffset - offset) / maxOffset).clamp(0.5, 1.0);

      double factor = (_scrollOffset / maxOffset).clamp(0.0, 1.0);

         Color startColor = Colors.transparent;
    Color endColor = Theme.of(context).canvasColor;


    // Interpolate between the start and end colors
     interpolatedColor = Color.lerp(startColor, endColor, factor)!;

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
          color: interpolatedColor,
        ),
        child: playerResponse.responseData.isNotEmpty
            ? Container(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      bottom: _backdropBottom,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).canvasColor,
                            borderRadius: BorderRadius.circular(10)),
                        height: 170,
                        width: MediaQuery.of(context).size.width * .93,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(),
                            ),
                            Expanded(
                              flex: 3,
                              child: Opacity(
                                opacity: _textOpacity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //Club Data
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 10),
                                      child: Row(
                                        children: [
                                          Image.network(
                                            playerResponse.responseData[0]
                                                .statistics[0].team!.logo!,
                                            width: 50,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Text(
                                              playerResponse
                                                  .responseData[0].player.name!,
                                              //textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),

                                    //Personal Details
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          //Height Data
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                playerResponse.responseData[0]
                                                    .player.height!,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                'Height',
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall!
                                                        .color!
                                                        .withOpacity(.5),
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),

                                          //Age Data
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                playerResponse.responseData[0]
                                                        .player.age!
                                                        .toString() +
                                                    ' Years',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                DateFormat('dd MMM yyyy')
                                                    .format(playerResponse
                                                        .responseData[0]
                                                        .player
                                                        .birth!
                                                        .date!),
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall!
                                                        .color!
                                                        .withOpacity(.5),
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    //Nationality
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 30,
                                        vertical: 10,
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Country:',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .color!
                                                    .withOpacity(.5),
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            playerResponse.responseData[0]
                                                .player.nationality!,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    //Player Image
                    Positioned(
                        bottom: 70,
                        left: 23,
                        child: Opacity(
                          opacity: _textOpacity,
                          child: Transform.scale(
                            scale: _imageScale,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Container(
                                child: Image.network(
                                  playerResponse.responseData[0].player.photo!,
                                  width: 150,
                                ),
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
              )
            : Container(
                margin: const EdgeInsets.only(top: 100.0, left: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Player Details
                    Container(),

                    //Player Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        child: Image.network(
                          playerResponse.responseData[0].player.photo!,
                          width: 120,
                        ),
                      ),
                    )
                  ],
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
                body: TabBarView(controller: _tabController, children: [
                  OverViewPage(
                    playerResponse: state.response,
                  ),
                  StatsViewPage(
                    playerResponse: state.response,
                  ),
                  Container()
                ]),
              );
            } else if (state is PlayerError) {
              return Center(child: Text(state.message));
            }
            return Container();
          }),
    );
  }
}
