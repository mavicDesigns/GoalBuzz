import 'package:flutter/material.dart';
import 'package:truck/assets/fonts/MavicIcons/mavic_i_cons_icons.dart';
import 'package:truck/src/screens/matchDetails/pageviews/details_page_screen.dart';

class MatchDetailsScreen extends StatefulWidget {
  const MatchDetailsScreen({super.key});

  @override
  State<MatchDetailsScreen> createState() => _MatchDetailsScreenState();
}

class _MatchDetailsScreenState extends State<MatchDetailsScreen>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late TabController _tabController;

  bool isExpanded = true;
  final collapsedBarHeight = 60.0;
  final expandedBarHeight = 200.0;

  double _textOpacity = 1.0;
  double _imageScale = 1.0;
  double _translateX = 0; // Initial value

  final List<String> pageViewNavs = ["Details", "Lineup", "Stats", "H2H"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this, length: pageViewNavs.length);
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      double offset = _scrollController.offset;
      double maxOffset =
          expandedBarHeight - 150; // Maximum scroll offset for the SliverAppBar

      double initialTranslateX = 0; // Translation value when expanded
      double finalTranslateX = 70; // Translation value when collapsed

      setState(() {
        _textOpacity = ((maxOffset - offset) / maxOffset).clamp(0.0, 1.0);
        _imageScale = ((maxOffset - offset) / maxOffset).clamp(0.6, 1.0);
        _translateX = (initialTranslateX +
                (offset / maxOffset) * (finalTranslateX - initialTranslateX))
            .clamp(initialTranslateX, finalTranslateX);
      });
    });
  }

  List<Widget> _buildPageNav() {
    return List.generate(pageViewNavs.length, (index) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Text(
          pageViewNavs[index],
          style: TextStyle(
              fontSize: 12,
              fontFamily: Theme.of(context).textTheme.bodyLarge!.fontFamily,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodySmall!.color!),
        ),
      );
    });
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: expandedBarHeight,
      pinned: true,
      forceElevated: true,
      shadowColor: Theme.of(context).cardTheme.color!.withOpacity(.5),
      actionsIconTheme: IconThemeData(
        opacity: _textOpacity,
      ),
      backgroundColor: Theme.of(context).cardTheme.color,
      collapsedHeight: collapsedBarHeight,
      flexibleSpace: AnimatedBuilder(
        animation: _scrollController,
        builder: (context, child) {
          return _buildFinishedScoreBar();
        },
      ),
      actions: [
        IconButton(
            onPressed: () => {},
            icon: Icon(
              MavicICons.share_ios_export,
            )),
        IconButton(
            onPressed: () => {}, icon: Icon(MavicICons.bell_notification)),
        IconButton(onPressed: () => {}, icon: Icon(MavicICons.star))
      ],
      bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: TabBar(
            onTap: (value) {
               _tabController.animateTo(value);
            },
            tabAlignment: TabAlignment.start,
            controller: _tabController,
            dividerColor: Theme.of(context).cardTheme.color,
            isScrollable: true,
            tabs: _buildPageNav(),
          )),
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
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: <Widget>[
              DetailsPageView(),
              DetailsPageView(),
              DetailsPageView(),
              DetailsPageView(),
            ],
          ),
        ));
  }

  Widget _buildFinishedScoreBar() {
    return Align(
        alignment: Alignment.center,
        child: Row(
          children: [
            //Home Team UI
            Expanded(
              flex: 2,
              child: Transform.translate(
                  offset: Offset(_translateX, 0),
                  child: Transform.scale(
                    scale: _imageScale,
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          Image.network(
                            'https://www.shutterstock.com/shutterstock/photos/2276193891/display_1500/stock-vector-manchester-city-icon-logo-emblem-sign-identity-design-vector-template-2276193891.jpg',
                            width: 50,
                          ),
                          Opacity(
                            opacity: _textOpacity,
                            child: Text(
                              'Man City',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .color),
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
            ),
            //Score UI
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(''),
                  Transform.scale(
                    scale: _imageScale,
                    child: Text(
                      '0 - 2',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color:
                              Theme.of(context).textTheme.displayLarge!.color),
                    ),
                  ),
                  Opacity(
                    opacity: _textOpacity,
                    child: Text(
                      'AP',
                      style: TextStyle(
                          fontSize: 13,
                          color: Theme.of(context).textTheme.bodyLarge!.color),
                    ),
                  ),
                ],
              ),
            ),

            //Away Tean UI
            Expanded(
                flex: 2,
                child: Transform.translate(
                  offset: Offset(-_translateX, 0),
                  child: Transform.scale(
                    scale: _imageScale,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          Image.network(
                            'https://www.shutterstock.com/shutterstock/photos/2276193891/display_1500/stock-vector-manchester-city-icon-logo-emblem-sign-identity-design-vector-template-2276193891.jpg',
                            width: 50,
                          ),
                          Opacity(
                            opacity: _textOpacity,
                            child: Text(
                              'Man City',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .color),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )),
          ],
        ));
  }
}



