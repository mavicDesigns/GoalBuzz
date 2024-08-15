// events.dart
import 'package:truck/src/models/players_model.dart';

abstract class PlayerEvent {}

class FetchPlayer extends PlayerEvent {
  final int id;

  FetchPlayer(this.id);
}


// states.dart
abstract class PlayerState {}

class PlayerInitial extends PlayerState {}

class PlayerLoading extends PlayerState {}

class PlayerLoaded extends PlayerState {
  final PlayerResponse response;

  PlayerLoaded(this.response);
}

class PlayerError extends PlayerState {
  final String message;

  PlayerError(this.message);
}

