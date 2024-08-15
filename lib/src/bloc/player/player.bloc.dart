// matches_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:truck/src/bloc/player/player_events.dart';
import 'package:truck/src/services/api/api_service.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  PlayerBloc() : super(PlayerInitial()) {
    on<FetchPlayer>((event, emit) async {
      emit(PlayerLoading());
      try {
        // Fetch topic details from repository
        final playerResponse = await fetchPlayer(event.id);
        emit(PlayerLoaded(playerResponse));
      } catch (e) {
        emit(PlayerError('Failed to fetch topic details: $e'));
      }
    });

  }
}
