// events.dart
import 'package:truck/src/models/api_response_model.dart';

abstract class FixtureEvent {}

class FetchFixtures extends FixtureEvent {
  final DateTime date;

  FetchFixtures(this.date);
}

// states.dart
abstract class FixturesState {}

class FixtureInitial extends FixturesState {}

class FixturesLoading extends FixturesState {}

class FixturesLoaded extends FixturesState {
  final ApiResponse response;

  FixturesLoaded(this.response);
}

class FixturesError extends FixturesState {
  final String message;

  FixturesError(this.message);
}
