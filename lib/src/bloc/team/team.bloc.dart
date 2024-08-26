// matches_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:truck/src/bloc/team/team_events.dart';
import 'package:truck/src/services/api/api_service.dart';

class TeamBloc extends Bloc<TeamEvent, TeamState> {
  TeamBloc() : super(TeamInitial()) {
    on<FetchTeamDetails>((event, emit) async {
      emit(TeamLoading());
      try {
        // Fetch topic details from repository
        final teamResponse = await fetchTeamDeatials(event.teamId);
        emit(TeamLoaded(teamResponse));
      } catch (e) {
        emit(TeamError('Failed to fetch topic details: $e'));
      }
    });

  }
}
