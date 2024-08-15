// events.dart
import 'package:truck/src/models/api_response_model.dart';

abstract class FixtureEvent {}

class FetchFixtures extends FixtureEvent {
  final DateTime date;

  FetchFixtures(this.date);
}


class FetchFixture extends FixtureEvent {
  final int fixtureId;

  FetchFixture(this.fixtureId);
}


class FetchH2H extends FixtureEvent {
  final int homeId;
    final int awayId;


  FetchH2H(this.homeId, this.awayId);
}


// states.dart
abstract class FixturesState {}

class FixtureInitial extends FixturesState {}

class FixturesLoading extends FixturesState {}

class FixturesLoaded extends FixturesState {
  final FixtureResponse response;

  FixturesLoaded(this.response);
}

class FixturesError extends FixturesState {
  final String message;

  FixturesError(this.message);
}
