import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:truck/src/bloc/fixtures/fixtures.bloc.dart';
import 'package:truck/src/bloc/fixtures/fixtures_events.dart';
import 'package:truck/src/models/api_response_model.dart';

class HeadToHeadPageView extends StatefulWidget {
  final Data response;

  const HeadToHeadPageView({super.key, required this.response});

  @override
  State<HeadToHeadPageView> createState() => _HeadToHeadPageViewState();
}

class _HeadToHeadPageViewState extends State<HeadToHeadPageView>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late FixturesBloc _fixturesBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fixturesBloc = FixturesBloc();

    _fixturesBloc.add(FetchH2H(
        widget.response.teams!.home['id'], widget.response.teams!.away['id']));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FixturesBloc, FixturesState>(
          bloc: _fixturesBloc,
          builder: (context, state) {
            if (state is FixturesLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is FixturesLoaded) {
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                      child: Column(
                        children: [_buildh2hCard(state.response.data)],
                      ),
                    ),
                  )
                ],
              );
            } else if (state is FixturesError) {
              return Center(child: Text(state.message));
            }
            return Container();
          }),
    );
  }

  Widget _buildh2hCard(List<Data> data) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total: ${data.length}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30,
            ),
            ...List.generate(data.length, (index) {
              return data[index].score!.fulltime!.home != null
                  ? Container(
                      margin: EdgeInsets.symmetric(vertical: 30),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(DateFormat('d MMM yyyy')
                                  .format(data[index].fixture!.date!)),
                              Container(
                                child: Text(data[index].league!.name!),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                data[index].teams!.home['logo'],
                                width: 30,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                child: Text(
                                  '${data[index].score!.fulltime!.home} - ${data[index].score!.fulltime!.away}',
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Image.network(
                                data[index].teams!.away['logo'],
                                width: 30,
                              ),
                            ],
                          ),
                           SizedBox(
                                height: 20,
                              ),
                          Divider(color: Theme.of(context).scaffoldBackgroundColor,)
                        ],
                      ),
                    )
                  : Container();
            })
          ],
        ),
      ),
    );
  }


  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
