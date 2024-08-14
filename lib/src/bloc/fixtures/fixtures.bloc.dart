// matches_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:truck/src/bloc/fixtures/fixtures_events.dart';
import 'package:truck/src/services/api/api_service.dart';

class FixturesBloc extends Bloc<FixtureEvent, FixturesState> {
  FixturesBloc() : super(FixtureInitial()) {
    on<FetchFixtures>((event, emit) async {
      emit(FixturesLoading());
      try {
        // Fetch topic details from repository
        final fixtureResponse = await fetchFixturesFromNetwork(event.date);
        emit(FixturesLoaded(fixtureResponse));
      } catch (e) {
        emit(FixturesError('Failed to fetch topic details: $e'));
      }
    });

    on<FetchFixture>((event, emit) async {
      emit(FixturesLoading());
      try {
        // Fetch topic details from repository
        final fixtureResponse = await fetchFixture(event.fixtureId);
        emit(FixturesLoaded(fixtureResponse));
      } catch (e) {
        emit(FixturesError('Failed to fetch topic details: $e'));
      }
    });


    on<FetchH2H>((event, emit) async {
      emit(FixturesLoading());
      try {
        // Fetch topic details from repository
        final fixtureResponse = await fetchH2h(event.homeId, event.awayId);
        emit(FixturesLoaded(fixtureResponse));
      } catch (e) {
        emit(FixturesError('Failed to fetch topic details: $e'));
      }
    });
  }
}
