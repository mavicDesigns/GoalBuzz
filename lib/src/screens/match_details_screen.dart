import 'package:flutter/material.dart';
import 'package:truck/assets/fonts/MavicIcons/mavic_i_cons_icons.dart';

class MatchDetailsScreen extends StatefulWidget {
  const MatchDetailsScreen({super.key});

  @override
  State<MatchDetailsScreen> createState() => _MatchDetailsScreenState();
}

class _MatchDetailsScreenState extends State<MatchDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            flexibleSpace: Padding(
              padding: const EdgeInsets.only(bottom: 45.0),
              child: Row(
                children: [
                  //Home Ui
                  Expanded(
                    flex: 2,
                    child: Container(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                            flex: 2,
                            child: Align(
                              alignment: Alignment.bottomRight,
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
