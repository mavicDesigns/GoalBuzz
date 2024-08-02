import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:truck/src/bloc/fixtures/fixtures.bloc.dart';
import 'package:truck/src/bloc/fixtures/fixtures_events.dart';
import 'package:truck/src/models/api_response_model.dart';
import 'package:truck/src/models/statistics.model.dart';

class StatsPageView extends StatefulWidget {
  final Response response;


  StatsPageView({required this.response});

  @override
  State<StatsPageView> createState() => _StatsPageViewState();
}

class _StatsPageViewState extends State<StatsPageView> {
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
              final statistics = state.response.response[0].statistics;
              print(statistics);

              if(statistics!.length > 0){
                 return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: statistics![0].statistics!.length,
                  itemBuilder: (context, index) {
                    return _buildStatisticRow(index, statistics);
                  },
                ),
              );
              }else{
                Center(child: Text('No Data for this match'));
              }

             
            } else if (state is FixturesError) {
              return Center(child: Text(state.message));
            }
            return Container();
          }),
    );
  }

  Widget _buildStatisticRow(int index, List<Statistics> stats) {
    final String statType = stats[0].statistics![index].type!;
    final dynamic statValueTeam1 = stats[0].statistics![index].value!;
    final dynamic statValueTeam2 = stats[1].statistics![index].value!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          statType,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            _buildTeamStatistic(statValueTeam1, stats[0].team!.logo!),
            SizedBox(width: 8),
            Expanded(child: _buildStatBar(statValueTeam1, statValueTeam2)),
            SizedBox(width: 8),
            _buildTeamStatistic(statValueTeam2,  stats[1].team!.logo!),
          ],
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildTeamStatistic(dynamic value, String logo) {
    return Column(
      children: [
        Image.network(logo, width: 40, height: 40),
        Text(value.toString()),
      ],
    );
  }

  Widget _buildStatBar(dynamic valueTeam1, dynamic valueTeam2) {
    double maxStat = max(valueTeam1 is int ? valueTeam1.toDouble() : 0.0,
        valueTeam2 is int ? valueTeam2.toDouble() : 0.0);
    return Row(
      children: [
        Expanded(
          flex: valueTeam1 is int ? valueTeam1 : 1,
          child: Container(height: 20, color: Colors.blue.withOpacity(0.7)),
        ),
        Expanded(
          flex: valueTeam2 is int ? valueTeam2 : 1,
          child: Container(height: 20, color: Colors.red.withOpacity(0.7)),
        ),
      ],
    );
  }
}
