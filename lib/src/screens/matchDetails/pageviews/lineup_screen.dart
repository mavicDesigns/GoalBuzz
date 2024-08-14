import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:truck/src/bloc/fixtures/fixtures.bloc.dart';
import 'package:truck/src/bloc/fixtures/fixtures_events.dart';
import 'package:truck/src/components/widget/custom_button.dart';
import 'package:truck/src/models/api_response_model.dart';
import 'package:truck/src/themes/light_theme.dart';

class LineUpPageView extends StatefulWidget {
  final Data response;

  const LineUpPageView({super.key, required this.response});

  @override
  State<LineUpPageView> createState() => _LineUpPageViewState();
}

class _LineUpPageViewState extends State<LineUpPageView>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late FixturesBloc _fixturesBloc;

  int _lineUpIndex = 0;

  late Lineup _currentLineup;
  late Data _responseData;

  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fixturesBloc = FixturesBloc();
    _tabController = TabController(vsync: this, length: 2);
    _responseData = widget.response;

    _fixturesBloc.add(FetchFixture(widget.response.fixture!.id!));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
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
              if(state.response.data[0].lineups!.isNotEmpty) {
_responseData = state.response.data[0];
              _currentLineup = _responseData.lineups![0];
              return CustomScrollView(
                slivers: [
                  _buildLineUp(state.response.data[0].lineups!),
                  _buildCoachCard(state.response.data[0]),
                  _buildSubstituesCard(state.response.data[0])
                ],
              );
              }else{
                 return Center(child: Text('Line up is still unavailable'));
              }
              
            } else if (state is FixturesError) {
              return Center(child: Text(state.message));
            }
            return Container();
          }),
    );
  }

  void _switchLineUpIndex(int index) {
    setState(() {
      _lineUpIndex = index;
    });
  }

  Widget _buildSubstituesCard(Data data) {
    Lineup lineup;

    _lineUpIndex == 0 ? lineup = data.lineups![0] : lineup = data.lineups![1];

    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Theme.of(context).cardTheme.color,
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Substitutes',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  ...List.generate(lineup.substitutes!.length, (index) {
                    return ListTile(
                      leading: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                                'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                            width: 40,
                            height:40,
                          )),
                          title: Text(lineup.substitutes![index].player!.name!, style: TextStyle(fontWeight: FontWeight.bold),),
                          subtitle:  Text(((lineup.substitutes![index].player!.pos!).toString()).split('.').last),
                    );
                  })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCoachCard(Data data) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Theme.of(context).cardTheme.color,
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Coach',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    _lineUpIndex == 0
                        ? data.lineups![0].coach!.photo!
                        : data.lineups![1].coach!.photo!,
                    width: 50,
                    height: 50,
                  ),
                ),
                title: Text(_lineUpIndex == 0
                    ? data.lineups![0].coach!.name!
                    : data.lineups![1].coach!.name!),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLineUp(List<Lineup> lineUps) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 730,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50),
          child: Column(
            children: [
              IndexedStack(
                index: _lineUpIndex,
                children: [
                  _buildFootballFieldWidget(lineUps[0]),
                  _buildFootballFieldWidget(lineUps[1]),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: 200,
                height: 45,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).cardTheme.color!,
                    ),
                    borderRadius: BorderRadius.circular(20)),
                child: Stack(
                  children: [
                    Transform.translate(
                      offset: Offset(_lineUpIndex == 1 ? 100 : 0, 0),
                      child: Container(
                        width: 100,
                        decoration: BoxDecoration(
                            color: Theme.of(context).cardTheme.color,
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                _switchLineUpIndex(0);
                              },
                              child: Text(
                                'Home',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                _switchLineUpIndex(1);
                              },
                              child: Text(
                                'Away',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFootballFieldWidget(Lineup lineUp) {
    return Center(
      child: CustomPaint(
        painter: FootballFieldPainter(),
        child: Stack(
          children: [
            Positioned(
                right: 0,
                child: Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Text(lineUp.formation!),
                )),
            Container(
              color: AppColors.primary1.withOpacity(.1),
              width: 370,
              height: 550,
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: _buildFormation(lineUp),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormation(Lineup lineUp) {
    List<Widget> formationRows = [];

    var formation =
        lineUp.formation!.split('-').map((s) => int.parse(s)).toList();
    formation.insert(0, 1); // Add the goalkeeper row

    for (int i = 0; i < formation.length; i++) {
      formationRows.add(_buildRow(lineUp.startXi!, i + 1, formation[i]));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: formationRows.reversed.toList(),
    );
  }

  Widget _buildRow(List<StartXi> players, int row, int count) {
    List<Widget> rowChildren = [];
    var rowPlayers = players
        .where((player) => player.player!.grid!.startsWith('$row:'))
        .toList();
    for (var player in rowPlayers) {
      rowChildren.add(_buildPlayer(player.player!));
    }
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: rowChildren,
      ),
    );
  }

  String extractLastName(String fullName) {
    // Split the string by space
    List<String> parts = fullName.split(' ');

    // If the first part contains a period, it's an initial, so the last name is the second part
    return parts.last;
  }

  Widget _buildPlayer(StartXiPlayer playerInfo) {
    return Expanded(
      child: Column(
        children: [
          CircleAvatar(
            radius: 20.0,
            backgroundColor: Color.fromARGB(255, 115, 137, 188),
            child: Text(
              playerInfo.number.toString(),
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 5),
          Text(
            extractLastName(playerInfo.name!),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
  
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class FootballFieldPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Color(0xFF4B3B89).withOpacity(.3)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Draw half pitch vertically
    canvas.drawRRect(
        RRect.fromLTRBR(0, 0, size.width, size.height, Radius.circular(5)),
        paint);

    canvas.drawRRect(
        RRect.fromLTRBAndCorners(
            size.width * .15, size.height, size.width * .85, size.height * .85,
            topRight: Radius.circular(5), topLeft: Radius.circular(5)),
        paint);

    canvas.drawArc(
      Rect.fromCircle(
          center: Offset(size.width / 2, size.height * .85), radius: 50),
      3.14,
      3.14,
      false,
      paint,
    );

    canvas.drawArc(
      Rect.fromCircle(center: Offset(size.width / 2, 0), radius: 70),
      3.14,
      -3.14,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
