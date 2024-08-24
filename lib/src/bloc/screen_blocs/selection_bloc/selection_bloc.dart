import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:truck/src/models/players_model.dart';
import 'package:truck/src/services/api/api_service.dart';

// Define Events
abstract class SelectionEvent {}

class InitializeData extends SelectionEvent {
  final List<Statistic> statistics;
  InitializeData(this.statistics);
}

class LeagueChanged extends SelectionEvent {
  final String selectedLeague;
  LeagueChanged(this.selectedLeague);
}

class YearChanged extends SelectionEvent {
  final String selectedYear;
  final int playerId;
  YearChanged(this.selectedYear, this.playerId);
}

// Define States
class SelectionState {
  final String? selectedLeague;
  final String? selectedYear;
  final List<Statistic> statistics;

  SelectionState(
      {this.selectedLeague, this.selectedYear, required this.statistics});
}

// Bloc Implementation
class SelectionBloc extends Bloc<SelectionEvent, SelectionState> {
  SelectionBloc() : super(SelectionState(statistics: [])) {
    on<InitializeData>((event, emit) async {
      final initialLeague =
          event.statistics.isNotEmpty ? event.statistics[0].league!.name : null;
      final selectedYear = event.statistics.isNotEmpty
          ? event.statistics[0].league!.season
          : null;
      emit(SelectionState(
        selectedLeague: initialLeague,
        selectedYear: selectedYear.toString(),
        statistics: event.statistics,
      ));
    });

    on<LeagueChanged>((event, emit) async {
      List<Statistic> filteredStatistics =
          _rearrangeStatistics(state.statistics, event.selectedLeague);
      emit(SelectionState(
        selectedLeague: event.selectedLeague,
        selectedYear: state.selectedYear,
        statistics: filteredStatistics,
      ));
    });

    on<YearChanged>((event, emit) async {
      PlayerResponse playerResponse = await fetchPlayer(event.playerId);
      List<Statistic> newStatistics = playerResponse.responseData[0].statistics;
      final initialLeague =
          newStatistics.isNotEmpty ? newStatistics[0].league!.name : null;
      emit(SelectionState(
        selectedLeague: initialLeague,
        selectedYear: event.selectedYear,
        statistics: newStatistics,
      ));
    });
  }

  List<Statistic> _rearrangeStatistics(
      List<Statistic> statistics, String selectedLeague) {
    final List<Statistic> rearrangedList = [];

    // Find the statistics for the selected league
    final selectedLeagueStat = statistics.firstWhere(
      (stat) => stat.league!.name == selectedLeague,
    );

    rearrangedList.add(selectedLeagueStat);
    // Add the rest of the statistics to the list, excluding the selected league
    rearrangedList.addAll(
        statistics.where((stat) => stat.league!.name != selectedLeague));

    return rearrangedList;
  }
}
