import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:truck/assets/fonts/MavicIcons/mavic_i_cons_icons.dart';
import 'package:truck/src/bloc/fixtures/fixtures.bloc.dart';
import 'package:truck/src/bloc/fixtures/fixtures_events.dart';
import 'package:truck/src/models/api_response_model.dart';
import 'package:truck/src/themes/dartk_theme.dart';

class StatsPageView extends StatefulWidget {
  final Data response;

  StatsPageView({required this.response});

  @override
  State<StatsPageView> createState() => _StatsPageViewState();
}

class _StatsPageViewState extends State<StatsPageView>  with AutomaticKeepAliveClientMixin{
  late FixturesBloc _fixturesBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fixturesBloc = FixturesBloc();
    _fixturesBloc.add(FetchFixture(widget.response.fixture!.id!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FixturesBloc, FixturesState>(
          bloc: _fixturesBloc,
          builder: (context, state) {
            if (state is FixturesLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is FixturesLoaded) {
              final statistics = state.response.data[0].statistics;
              final List<TeamPlayers> teamPlayers =
                  state.response.data[0].teamPlayers!;

              if (statistics!.isNotEmpty) {
                return CustomScrollView(
                  slivers: [
                    
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 8.0),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return _buildStatisticRow(index, statistics);
                          },
                          childCount: statistics[0].statistics!.length,
                        ),
                      ),
                    ),

                    SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical:  20.0),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Player Stats', style: Theme.of(context).textTheme.displaySmall,),
                              Text('View All', style: TextStyle(color: Colors.blueAccent),),
                            ],
                          ),
                        )),

                    _buildShotsLeaderboard(teamPlayers),
                    _buildDribblesLeaderboard(teamPlayers),
                    _buildAccuratePassesLeaderboard(teamPlayers),
                  ],
                );
              } else {
                return const Center(child: Text('No Data for this match'));
              }
            } else if (state is FixturesError) {
              return Center(child: Text(state.message));
            }
            return Container();
          }),
    );
  }

  Widget _buildStatisticRow(int index, List<Statistics> responStats) {
    for (var teamStats in responStats) {
      int ballPossessionIndex = teamStats.statistics!
          .indexWhere((stat) => stat.type == "Ball Possession");
      if (ballPossessionIndex != -1) {
        var ballPossessionStat =
            teamStats.statistics!.removeAt(ballPossessionIndex);
        teamStats.statistics!.insert(0, ballPossessionStat);
      }
    }

    final String statType = responStats[0].statistics![index].type!;
    final dynamic statValueTeam1 = responStats[0].statistics![index].value!;
    final dynamic statValueTeam2 = responStats[1].statistics![index].value!;
    double percentTeam1;
    double percentTeam2;

    // Calculate percentage values
    if (statType == "Ball Possession") {
      percentTeam1 = double.parse(statValueTeam1.replaceAll('%', ''));
      percentTeam2 = double.parse(statValueTeam2.replaceAll('%', ''));
    } else {
      // Calculate percentage values for other types
      percentTeam1 = _calculatePercentage(statValueTeam1, statValueTeam2);
      percentTeam2 = _calculatePercentage(statValueTeam2, statValueTeam1);
    }

    // Determine bar colors based on percentage comparison
    Color colorTeam1 = percentTeam1 >= percentTeam2
        ? Color.fromARGB(255, 198, 41, 41)
        : Color(0xFF4B3B89);
    Color colorTeam2 = percentTeam2 > percentTeam1
        ? Color.fromARGB(255, 198, 41, 41)
        : Color(0xFF4B3B89);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTeamStatistic(statValueTeam1),
              Text(
                statType,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
              _buildTeamStatistic(statValueTeam2),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: _buildStatBar(
                      percentTeam1, colorTeam1, Alignment.bottomRight)),
              SizedBox(width: 8),
              Expanded(
                  child: _buildStatBar(
                      percentTeam2, colorTeam2, Alignment.bottomLeft)),
            ],
          ),
        ],
      ),
    );
  }

  double _calculatePercentage(dynamic value, dynamic otherValue) {
    if (value is int && otherValue is int) {
      int total = value + otherValue;
      return (total == 0) ? 0 : (value / total) * 100;
    } else if (value is double && otherValue is double) {
      double total = value + otherValue;
      return (total == 0) ? 0 : (value / total) * 100;
    }
    return 0;
  }

  Widget _buildTeamStatistic(
    dynamic value,
  ) {
    return Text(value.toString());
  }

  Widget _buildStatBar(double percentage, Color color, Alignment alignment) {
    return Container(
      height: 7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xFF4B3B89).withOpacity(.2),
      ),
      alignment: alignment, // where to position the child
      child: SizedBox(
        height: 7,
        child: Container(
          width: percentage,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: color,
          ),
        ),
      ),
    );
  }

  Widget _buildShotsLeaderboard(List<TeamPlayers> teams) {
    // Extract players with non-null total shots from all teams
    List<MatchPlayers> players = [];
    for (var team in teams) {
      players.addAll(team.players!
          .where((player) => player.statistics![0].shots!.total != null));
    }

    // Sort players by total shots in descending order
    players.sort((a, b) => b.statistics![0].shots!.total!
        .compareTo(a.statistics![0].shots!.total!));

    // If no valid players, show a message
    if (players.isEmpty) {
      return Center(child: Text('No players with shot data available.'));
    }

    List<Widget> tiles = List.generate(3, (index) {
      final player = players[index];
      return ListTile(
          leading: ClipRRect(
              borderRadius:
                  BorderRadius.circular(20.0), // Adjust the radius here

              child:
                  Image.network(player.player!.photo!, width: 30, height: 30)),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(player.player!.name!),
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(20.0), // Adjust the radius here

                child: Image.network(
                  teams
                      .firstWhere((team) => team.players!.contains(player))
                      .team!
                      .logo!,
                  width: 30,
                  height: 20,
                ),
              ),
            ],
          ),
          trailing: Text('${player.statistics![0].shots!.total!}'));
    });

    return SliverToBoxAdapter(
      child:
       Container(
        height: 300,
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(10.0), // Adjust the radius here
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Shots',
                  style: TextStyle(fontSize: 18),
                ),
                Icon(MavicICons.chevron_right)
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ...tiles
          ],
        ),
      ),
    );
  }

 Widget _buildDribblesLeaderboard(List<TeamPlayers> teams) {
    // Extract players with non-null total shots from all teams
    List<MatchPlayers> players = [];
    for (var team in teams) {
      players.addAll(team.players!
          .where((player) => player.statistics![0].dribbles!.success != null));
    }

    // Sort players by total shots in descending order
    players.sort((a, b) => b.statistics![0].dribbles!.success!
        .compareTo(a.statistics![0].dribbles!.success!));

    // If no valid players, show a message
    if (players.isEmpty) {
      return Center(child: Text('No players with Dribbles data available.'));
    }

    List<Widget> tiles = List.generate(3, (index) {
      final player = players[index];
      return ListTile(
          leading: ClipRRect(
              borderRadius:
                  BorderRadius.circular(20.0), // Adjust the radius here

              child:
                  Image.network(player.player!.photo!, width: 30, height: 30)),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(player.player!.name!),
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(20.0), // Adjust the radius here

                child: Image.network(
                  teams
                      .firstWhere((team) => team.players!.contains(player))
                      .team!
                      .logo!,
                  width: 30,
                  height: 20,
                ),
              ),
            ],
          ),
          trailing: Text('${player.statistics![0].dribbles!.success!}'));
    });

    return SliverToBoxAdapter(
      child: Container(
        height: 300,
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(10.0), // Adjust the radius here
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Successful Dribbles',
                  style: TextStyle(fontSize: 18),
                ),
                Icon(MavicICons.chevron_right)
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ...tiles
          ],
        ),
      ),
    );
  }


 Widget _buildAccuratePassesLeaderboard(List<TeamPlayers> teams) {
    // Extract players with non-null total shots from all teams
    List<MatchPlayers> players = [];
    for (var team in teams) {
      players.addAll(team.players!
          .where((player) => player.statistics![0].passes!.accuracy != null));
    }

    players.sort((a, b){
      int da = int.parse(a.statistics![0].passes!.accuracy!);
            int db = int.parse(b.statistics![0].passes!.accuracy!);
            return db.compareTo(da);

    });

    // If no valid players, show a message
    if (players.isEmpty) {
      return Center(child: Text('No players with Dribbles data available.'));
    }

    List<Widget> tiles = List.generate(3, (index) {
      final player = players[index];
      return ListTile(
          leading: ClipRRect(
              borderRadius:
                  BorderRadius.circular(20.0), // Adjust the radius here

              child:
                  Image.network(player.player!.photo!, width: 30, height: 30)),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(player.player!.name!),
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(20.0), // Adjust the radius here

                child: Image.network(
                  teams
                      .firstWhere((team) => team.players!.contains(player))
                      .team!
                      .logo!,
                  width: 30,
                  height: 20,
                ),
              ),
            ],
          ),
          trailing: Text('${player.statistics![0].passes!.accuracy!}'));
    });

    return SliverToBoxAdapter(
      child: Container(
        height: 300,
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(10.0), // Adjust the radius here
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Accurate Passes',
                  style: TextStyle(fontSize: 18),
                ),
                Icon(MavicICons.chevron_right)
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ...tiles
          ],
        ),
      ),
    );
  }
  
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}
