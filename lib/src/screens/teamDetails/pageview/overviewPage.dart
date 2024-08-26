import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:truck/src/models/team_response_model.dart';
import 'package:truck/src/themes/dartk_theme.dart';

class OverViewPage extends StatefulWidget {
  final TeamDetailsResponse teamDetailsResponse;

  const OverViewPage({Key? key, required this.teamDetailsResponse})
      : super(key: key);

  @override
  State<OverViewPage> createState() => _OverViewPageState();
}

class _OverViewPageState extends State<OverViewPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: RefreshIndicator(
        onRefresh: _onRefresh,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            children: [
              //NextMatch
              _buildTeamCard()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTeamCard() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    border: Border(bottom: BorderSide(color: Theme.of(context).canvasColor,width: 2)),
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).cardTheme.color!,
                  Theme.of(context).cardTheme.color!,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            width: 500,
            height: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Next Match',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'LaLiga',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(width: 10),
                          Image.asset(
                            'lib/assets/images/laliga.png',
                            width: 25,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //Home Ui
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'lib/assets/images/chelsea.png',
                            width: 70,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Chelsea')
                        ],
                      ),
                    ),

                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '12:30',
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Today')
                        ],
                      ),
                    ),

                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'lib/assets/images/madrid.png',
                            width: 70,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Real Madrid')
                        ],
                      ),
                    )
                  ],
                ),
               
              ],
            ),
          ),
            Container(
                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
                    color: Color(0xFF2B2E3A),
                  ),
                  child: Center(
                    child: Text(
                          'View All Matches',
                          style: TextStyle(fontSize: 16),
                        ),
                  )
                ),
        ],
      ),
    );
  }

  Future<void> _onRefresh() async {
    await Future.delayed(Duration(seconds: 5));
  }

  @override
  bool get wantKeepAlive => true;
}
