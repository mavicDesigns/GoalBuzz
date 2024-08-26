// events.dart
import 'package:truck/src/models/standings_response_model.dart';
import 'package:truck/src/models/team_response_model.dart';

abstract class StandingsEvent {}

class FetchStandings extends StandingsEvent {
  final int teamId;

  FetchStandings(this.teamId);
}


// states.dart
abstract class StandingsState {}

class StandingsInitial extends StandingsState {}

class StandingsLoading extends StandingsState {}

class StandingsLoaded extends StandingsState {
  final StandingsResponse response;

  StandingsLoaded(this.response);
}

class StandingsError extends StandingsState {
  final String message;

  StandingsError(this.message);
}
