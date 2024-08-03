import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:truck/src/bloc/fixtures/fixtures.bloc.dart';
import 'package:truck/src/bloc/fixtures/fixtures_events.dart';
import 'package:truck/src/components/widget/custom_button.dart';
import 'package:truck/src/models/api_response_model.dart';
import 'package:truck/src/models/line_up_model.dart';
import 'package:truck/src/themes/light_theme.dart';

class LineUpPageView extends StatefulWidget {
  final Data response;

  const LineUpPageView({super.key, required this.response});

  @override
  State<LineUpPageView> createState() => _LineUpPageViewState();
}

class _LineUpPageViewState extends State<LineUpPageView> {
  late FixturesBloc _fixturesBloc;

  int _lineUpIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fixturesBloc = FixturesBloc();
    _fixturesBloc.add(FetchFixture(widget.response.fixture!.id!));
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
                slivers: [_buildLineUp(state.response.data[0].lineups!)],
              );
            } else if (state is FixturesError) {
              return Center(child: Text(state.message));
            }
            return Container();
          }),
    );
  }

  Widget _buildLineUp(List<Lineup> lineUps) {


    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50),
        child: _buildFootballFieldWidget(lineUps[1]),
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
              child: _buildFormation(lineUp),
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
      children: formationRows,
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

    // Draw center circle
    canvas.drawRRect(
        RRect.fromLTRBAndCorners(size.width / 4, 0, size.width / 4 * 3, 90,
            bottomRight: Radius.circular(5), bottomLeft: Radius.circular(5)),
        paint);

    // Draw goal box
    canvas.drawRRect(
        RRect.fromLTRBAndCorners(size.width / 3, 0, size.width / 3 * 2, 40,
            bottomRight: Radius.circular(5), bottomLeft: Radius.circular(5)),
        paint);
    // Draw arc

    canvas.drawArc(
      Rect.fromCircle(center: Offset(size.width / 2, size.height), radius: 70),
      3.14,
      3.14,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
