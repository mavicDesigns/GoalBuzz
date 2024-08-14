import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:truck/assets/fonts/MavicIcons/mavic_i_cons_icons.dart';
import 'package:truck/src/bloc/fixtures/fixtures.bloc.dart';
import 'package:truck/src/bloc/fixtures/fixtures_events.dart';
import 'package:truck/src/models/api_response_model.dart';

class DetailsPageView extends StatefulWidget {
  final Data response;

  const DetailsPageView({super.key, required this.response});

  @override
  State<DetailsPageView> createState() => _DetailsPageViewState();
}

class _DetailsPageViewState extends State<DetailsPageView>  with AutomaticKeepAliveClientMixin{
  late FixturesBloc _fixturesBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fixturesBloc = FixturesBloc();
    _fixturesBloc.add(FetchFixture(widget.response.fixture!.id!));
  }

  Future<void> _onRefresh() async {
    await Future.delayed(Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: BlocBuilder<FixturesBloc, FixturesState>(
          bloc: _fixturesBloc,
          builder: (context, state) {
            if (state is FixturesLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is FixturesLoaded) {
              final fixture = state.response;
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 50),
                child: Column(
                  children: [_buildDetailsCard()],
                ),
              );
            } else if (state is FixturesError) {
              return Center(child: Text(state.message));
            }
            return Container();
          }),
    );
  }

  Widget _buildDetailsCard() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Icon(
                    MavicICons.calendar_week,
                    size: 16,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Today 1:20',
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Icon(
                    MavicICons.globe,
                    size: 16,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Club Friendlies',
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
