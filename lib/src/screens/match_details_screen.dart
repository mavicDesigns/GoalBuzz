import 'package:flutter/material.dart';
import 'package:truck/assets/fonts/MavicIcons/mavic_i_cons_icons.dart';

class MatchDetailsScreen extends StatefulWidget {
  const MatchDetailsScreen({super.key});

  @override
  State<MatchDetailsScreen> createState() => _MatchDetailsScreenState();
}

class _MatchDetailsScreenState extends State<MatchDetailsScreen> {
  late ScrollController _scrollController;
  bool isExpanded = true;
  final collapsedBarHeight = 60.0;
  final expandedBarHeight = 200.0;

  double _textOpacity = 1.0;
  double _imageScale = 1.0;
  double _translateX = 0; // Initial value

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      double offset = _scrollController.offset;
      double maxOffset =
          expandedBarHeight - 150; // Maximum scroll offset for the SliverAppBar

      double initialTranslateX = 0; // Translation value when expanded
      double finalTranslateX = 50; // Translation value when collapsed

      setState(() {
        _textOpacity = ((maxOffset - offset) / maxOffset).clamp(0.0, 1.0);
        _imageScale = ((maxOffset - offset) / maxOffset).clamp(0.6, 1.0);
        _translateX = (initialTranslateX +
                (offset / maxOffset) * (finalTranslateX - initialTranslateX))
            .clamp(initialTranslateX, finalTranslateX);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: expandedBarHeight,
            pinned: true,
            actionsIconTheme: IconThemeData(
              opacity: _textOpacity,
            ),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                  onPressed: () => {},
                  icon: Icon(MavicICons.bell_notification)),
              IconButton(onPressed: () => {}, icon: Icon(MavicICons.star))
            ],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: Container(
                child: Row(
                  children: [
                    Text('data'),
                    Text('data'),
                    Text('data'),
                    Text('data'),
                  ],
                ),
              ),
            ),
          ),
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.teal[70],
                  child: Text('grid item $index'),
                );
              },
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              childAspectRatio: 2.0,
            ),
          )
        ],
      ),
    );
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
                    height: 10,
                  ),
                  Text(''),
                  Transform.scale(
                    scale: _imageScale,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '0',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .color),
                        ),
                        SizedBox(
                          width: 50,
                          child: Text(
                            '-',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .color),
                          ),
                        ),
                        Text(
                          '2',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .color),
                        ),
                      ],
                    ),
                  ),
                  Opacity(
                    opacity: _textOpacity,
                    child: Text(
                      'Delayed',
                      style: TextStyle(
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
