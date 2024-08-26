// matches_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:truck/src/bloc/standings/standings_events.dart';
import 'package:truck/src/bloc/team/team_events.dart';
import 'package:truck/src/services/api/api_service.dart';

class StandingsBloc extends Bloc<StandingsEvent, StandingsState> {
  StandingsBloc() : super(StandingsInitial()) {
    on<FetchStandings>((event, emit) async {
      emit(StandingsLoading());
      try {
        // Fetch topic details from repository
        final standings = await fetchStandings(event.teamId);
        emit(StandingsLoaded(standings));
      } catch (e) {
        emit(StandingsError('Failed to fetch topic details: $e'));
      }
    });

  }
}
