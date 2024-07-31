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
  double paddingValue = 45;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      double offset = _scrollController.offset;
      double maxOffset =
          expandedBarHeight - 150; // Maximum scroll offset for the SliverAppBar

      setState(() {
        _textOpacity = ((maxOffset - offset) / maxOffset).clamp(0.0, 1.0);
        _imageScale = ((maxOffset - offset) / maxOffset).clamp(0.6, 1.0);
        paddingValue = ((maxOffset - offset) / maxOffset).clamp(10, 45);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: expandedBarHeight,
            pinned: true,
            collapsedHeight: collapsedBarHeight,
            flexibleSpace: AnimatedBuilder(
              animation: _scrollController,
              builder: (context, child) {
                return Container(
                  child: Row(
                    children: [
                      //Home Ui
                      Expanded(
                        flex: 2,
                        child:
                         Container(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                                flex: 2,
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Transform.scale(
                                    scale: _imageScale,
                                    child: Image.network(
                                      'https://www.shutterstock.com/shutterstock/photos/2276193891/display_1500/stock-vector-manchester-city-icon-logo-emblem-sign-identity-design-vector-template-2276193891.jpg',
                                      width: 70,
                                    ),
                                  ),
                                )),
                            Opacity(
                              opacity: _textOpacity,
                              child: Text(
                                'Man City',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .textTheme
                                        .displayLarge!
                                        .color),
                              ),
                            )
                          ],
                        )),
                      ),
                      //Score Ui
                      Expanded(
                        flex: 3,
                        child: Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(''),
                                Text(
                                  '12:00',
                                  style: TextStyle(
                                      fontSize: 32,
                                      color: Theme.of(context)
                                          .textTheme
                                          .displayLarge!
                                          .color),
                                ),
                                Text(
                                  'Delayed',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .color),
                                ),
                              ],
                            )),
                      ),
                      //Away Ui
                      Expanded(
                        flex: 2,
                        child: Container(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                flex: 2,
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Image.network(
                                    'https://www.shutterstock.com/shutterstock/photos/2276193891/display_1500/stock-vector-manchester-city-icon-logo-emblem-sign-identity-design-vector-template-2276193891.jpg',
                                    width: 70,
                                  ),
                                )),
                            Text(
                              'Man City',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .color),
                            )
                          ],
                        )),
                      ),
                    ],
                  ),
                );
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
}
