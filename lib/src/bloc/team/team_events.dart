// events.dart
import 'package:truck/src/models/players_model.dart';
import 'package:truck/src/models/team_response_model.dart';

abstract class TeamEvent {}

class FetchTeamDetails extends TeamEvent {
  final int teamId;

  FetchTeamDetails(this.teamId);
}


class FetchTeam extends TeamEvent {
  final int id;

  FetchTeam(this.id);
}

// states.dart
abstract class TeamState {}

class TeamInitial extends TeamState {}

class TeamLoading extends TeamState {}

class TeamLoaded extends TeamState {
  final TeamDetailsResponse response;

  TeamLoaded(this.response);
}

class TeamError extends TeamState {
  final String message;

  TeamError(this.message);
}
