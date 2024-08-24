import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:truck/src/bloc/player/player.bloc.dart';
import 'package:truck/src/bloc/player/player_events.dart';
import 'package:truck/src/bloc/screen_blocs/selection_bloc/selection_bloc.dart';
import 'package:truck/src/models/players_model.dart';

class StatsViewPage extends StatefulWidget {
  final PlayerResponse playerResponse;

  const StatsViewPage({Key? key, required this.playerResponse})
      : super(key: key);

  @override
  State<StatsViewPage> createState() => _StatsViewPageState();
}

class _StatsViewPageState extends State<StatsViewPage>
    with AutomaticKeepAliveClientMixin {
  late SelectionBloc _selectionBloc;

  final List<String> leagues = [
    'Ligue 1',
    'Ligue 2',
    'National',
    'Coupe de France'
  ];

  // List of years (up to 5 years span)
  final List<String> years = List.generate(5, (index) {
    final year = DateTime.now().year - index;
    return year.toString();
  });

  String? selectedLeague;
  String? selectedYear;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectionBloc = SelectionBloc();
    _selectionBloc
        .add(InitializeData(widget.playerResponse.responseData[0].statistics));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final leagues = widget.playerResponse.responseData[0].statistics
        .map((stat) => stat.league!.name! as String)
        .toSet()
        .toList();
    final years = List.generate(5, (index) {
      final year = DateTime.now().year - index;
      return year.toString();
    });
    return SingleChildScrollView(
      child: BlocBuilder<SelectionBloc, SelectionState>(
          bloc: _selectionBloc,
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: Column(
                children: [
                  Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Dropdown for selecting the French league
                          DropdownButton<String>(
                            hint: Text("Select League"),
                            value: state.selectedLeague ?? leagues.first,
                            items: leagues.map((String league) {
                              return DropdownMenuItem<String>(
                                value: league,
                                child: Text(league),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              _selectionBloc.add(LeagueChanged(newValue!));
                            },
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          // Dropdown for selecting the year
                          DropdownButton<String>(
                            hint: Text("Select Year"),
                            value: state.selectedYear,
                            items: years.map((String year) {
                              return DropdownMenuItem<String>(
                                value: year,
                                child: Text(year),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              _selectionBloc.add(YearChanged(
                                  newValue!,
                                  widget.playerResponse.responseData[0].player
                                      .id!));
                            },
                          ),
                        ],
                      )),
                  state.statistics.isNotEmpty
                      ? Column(
                          children: [
                            //Match Stats
                           Theme(
                              data: Theme.of(context)
                                  .copyWith(dividerColor:Theme.of(context).cardColor.withOpacity(.5)),
                              child: ExpansionTile(
                                initiallyExpanded: true,
                                backgroundColor: Colors.transparent,
                                title: Text('Matches'),
                                children: [
                                  ListTile(
                                    title: Text('Total Played',
                                        style: TextStyle(fontSize: 13)),
                                    trailing: Text(
                                        '${state.statistics[0].games!.appearences ?? 0}',
                                        style: TextStyle(fontSize: 13)),
                                  ),
                                  ListTile(
                                    title: Text('Started',
                                        style: TextStyle(fontSize: 14)),
                                    trailing: Text(
                                      '${state.statistics[0].games!.lineups ?? 0}',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                  ListTile(
                                    title: Text('Minutes per Game',
                                        style: TextStyle(fontSize: 13)),
                                    trailing: Text(
                                        '${(state.statistics[0].games!.minutes! / state.statistics[0].games!.appearences!).toStringAsFixed(0)}',
                                        style: TextStyle(fontSize: 13)),
                                  ),
                                ],
                              ),
                            ),

                            //Attacking Stats
                            Theme(
                              data: Theme.of(context)
                                  .copyWith(dividerColor:Theme.of(context).cardColor.withOpacity(.5)),
                              child: ExpansionTile(
                                initiallyExpanded: true,
                                backgroundColor: Colors.transparent,
                                title: Text(
                                  'Attacking',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                children: [
                                  ListTile(
                                    title: Text('Goals',
                                        style: TextStyle(fontSize: 13)),
                                    trailing: Text(
                                        '${state.statistics[0].goals!.total ?? 0}',
                                        style: TextStyle(fontSize: 13)),
                                  ),
                                  ListTile(
                                    title: Text('Scoring Frequency',
                                        style: TextStyle(fontSize: 13)),
                                    trailing: Text(
                                        '${(state.statistics[0].games!.minutes! / state.statistics[0].goals!.total!).toStringAsFixed(0)} min',
                                        style: TextStyle(fontSize: 13)),
                                  ),
                                  ListTile(
                                    title: Text('Goals per Game',
                                        style: TextStyle(fontSize: 13)),
                                    trailing: Text(
                                        '${(state.statistics[0].goals!.total! / state.statistics[0].games!.appearences!).toStringAsFixed(1)}',
                                        style: TextStyle(fontSize: 13)),
                                  ),
                                  ListTile(
                                    title: Text('Shots per Game',
                                        style: TextStyle(fontSize: 13)),
                                    trailing: Text(
                                        '${(state.statistics[0].shots!.total! / state.statistics[0].games!.appearences!).toStringAsFixed(1)}',
                                        style: TextStyle(fontSize: 13)),
                                  ),
                                  ListTile(
                                    title: Text('Shots on target per Game',
                                        style: TextStyle(fontSize: 13)),
                                    trailing: Text(
                                        '${(state.statistics[0].shots!.on! / state.statistics[0].games!.appearences!).toStringAsFixed(1)}',
                                        style: TextStyle(fontSize: 13)),
                                  ),
                                ],
                              ),
                            ),

                            //Passing Stats
                           Theme(
                              data: Theme.of(context)
                                  .copyWith(dividerColor:Theme.of(context).cardColor.withOpacity(.5)),
                              child: ExpansionTile(
                                initiallyExpanded: true,
                                backgroundColor: Colors.transparent,
                                title: Text(
                                  'Passing',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                children: [
                                  ListTile(
                                    title: Text('Assists',
                                        style: TextStyle(fontSize: 13)),
                                    trailing: Text(
                                        '${state.statistics[0].goals!.assists ?? 0}',
                                        style: TextStyle(fontSize: 13)),
                                  ),
                                  ListTile(
                                    title: Text('Total Passes',
                                        style: TextStyle(fontSize: 13)),
                                    trailing: Text(
                                        '${state.statistics[0].passes!.total ?? 0}',
                                        style: TextStyle(fontSize: 13)),
                                  ),
                                  ListTile(
                                    title: Text('Key Passes',
                                        style: TextStyle(fontSize: 13)),
                                    trailing: Text(
                                        '${state.statistics[0].passes!.key ?? 0}',
                                        style: TextStyle(fontSize: 13)),
                                  ),
                                  ListTile(
                                    title: Text('Accurate per Game',
                                        style: TextStyle(fontSize: 13)),
                                    trailing: Text(
                                        '${(state.statistics[0].passes!.accuracy! / state.statistics[0].games!.appearences!).toStringAsFixed(1)}',
                                        style: TextStyle(fontSize: 13)),
                                  ),
                                ],
                              ),
                            ),
                            //Defense Stats
                           Theme(
                              data: Theme.of(context)
                                  .copyWith(dividerColor:Theme.of(context).cardColor.withOpacity(.5)),
                              child: ExpansionTile(
                                initiallyExpanded: true,
                                backgroundColor: Colors.transparent,
                                title: Text(
                                  'Defensive',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                children: [
                                  ListTile(
                                    title: Text('Interceptions per game',
                                        style: TextStyle(fontSize: 13)),
                                    trailing: Text(
                                        '${(state.statistics[0].tackles!.interceptions! / state.statistics[0].games!.appearences!).toStringAsFixed(1)}',
                                        style: TextStyle(fontSize: 13)),
                                  ),
                                  ListTile(
                                    title: Text('Tackles per Game',
                                        style: TextStyle(fontSize: 13)),
                                    trailing: Text(
                                        '${(state.statistics[0].tackles!.total! / state.statistics[0].games!.appearences!).toStringAsFixed(1)}',
                                        style: TextStyle(fontSize: 13)),
                                  ),
                                  ListTile(
                                    title: Text('Possession Won',
                                        style: TextStyle(fontSize: 13)),
                                    trailing: Text(
                                        '${(state.statistics[0].tackles!.interceptions! / state.statistics[0].tackles!.total!).toStringAsFixed(1)}',
                                        style: TextStyle(fontSize: 13)),
                                  ),
                                  ListTile(
                                    title: Text('Dribbled Past per game',
                                        style: TextStyle(fontSize: 13)),
                                    trailing: Text(
                                        '${(state.statistics[0].dribbles!.past! / state.statistics[0].games!.appearences!).toStringAsFixed(1)}',
                                        style: TextStyle(fontSize: 13)),
                                  ),
                                  ListTile(
                                    title: Text('Penalties Commited',
                                        style: TextStyle(fontSize: 13)),
                                    trailing: Text(
                                        '${state.statistics[0].penalty!.commited}',
                                        style: TextStyle(fontSize: 13)),
                                  ),
                                ],
                              ),
                            ),
                            //Dribbling Stats
                             Theme(
                              data: Theme.of(context)
                                  .copyWith(dividerColor:Theme.of(context).cardColor.withOpacity(.5)),
                              child: ExpansionTile(
                                initiallyExpanded: true,
                                backgroundColor: Colors.transparent,
                                title: Text(
                                  'Dribbling',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                children: [
                                  ListTile(
                                    title: Text('Succ. Dribbles per game',
                                        style: TextStyle(fontSize: 13)),
                                    trailing: Text(
                                        '${(state.statistics[0].dribbles!.success! / state.statistics[0].games!.appearences!).toStringAsFixed(1)}',
                                        style: TextStyle(fontSize: 13)),
                                  ),
                                  ListTile(
                                    title: Text('Total duel won per Game',
                                        style: TextStyle(fontSize: 13)),
                                    trailing: Text(
                                        '${(state.statistics[0].duels!.won! / state.statistics[0].games!.appearences!).toStringAsFixed(1)}',
                                        style: TextStyle(fontSize: 13)),
                                  ),
                                ],
                              ),
                            ),

                            //Disciple Stats
                            Theme(
                              data: Theme.of(context)
                                  .copyWith(dividerColor:Theme.of(context).cardColor.withOpacity(.5)),
                              child: ExpansionTile(
                                initiallyExpanded: true,
                                backgroundColor: Colors.transparent,
                                title: Text(
                                  'Discipline',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                children: [
                                  ListTile(
                                    title: Text('Yellow Card',
                                        style: TextStyle(fontSize: 13)),
                                    trailing: Text(
                                        '${state.statistics[0].cards!.yellow ?? 0}',
                                        style: TextStyle(fontSize: 13)),
                                  ),

                                   ListTile(
                                    title: Text('Double Yellow Card',
                                        style: TextStyle(fontSize: 13)),
                                    trailing: Text(
                                        '${state.statistics[0].cards!.yellowred ?? 0}',
                                        style: TextStyle(fontSize: 13)),
                                  ),
                                ListTile(
                                    title: Text('Straight Red Card',
                                        style: TextStyle(fontSize: 13)),
                                    trailing: Text(
                                        '${state.statistics[0].cards!.red ?? 0}',
                                        style: TextStyle(fontSize: 13)),
                                  ),
                                
                                ],
                              ),
                            ),
                          ],
                        )
                      : Container(),
                ],
              ),
            );
          }),
    );
  }

  Future<void> _onRefresh() async {
    await Future.delayed(Duration(seconds: 2));
  }

  @override
  bool get wantKeepAlive => true;
}
