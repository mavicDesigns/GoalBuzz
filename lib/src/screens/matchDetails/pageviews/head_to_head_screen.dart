import 'package:flutter/material.dart';
import 'package:truck/src/themes/light_theme.dart';

class FootballField extends StatefulWidget {
  @override
  _FootballFieldState createState() => _FootballFieldState();
}

class _FootballFieldState extends State<FootballField> {
  final Map<String, dynamic> lineupData = {
    "lineups": [
      {
        "team": {
          "id": 452,
          "name": "Tigre",
          "logo": "https://media.api-sports.io/football/teams/452.png",
          "colors": {
            "player": {
              "primary": "ffffff",
              "number": "0d0d0d",
              "border": "ffffff"
            },
            "goalkeeper": {
              "primary": "d60e00",
              "number": "ffffff",
              "border": "d60e00"
            }
          }
        },
        "coach": {
          "id": 22466,
          "name": "S. Domínguez",
          "photo": "https://media.api-sports.io/football/coachs/22466.png"
        },
        "formation": "4-1-4-1",
        "startXI": [
          {
            "player": {
              "id": 201825,
              "name": "F. Zenobio",
              "number": 12,
              "pos": "G",
              "grid": "1:1"
            }
          },
          {
            "player": {
              "id": 5671,
              "name": "M. Ortega",
              "number": 4,
              "pos": "D",
              "grid": "2:4"
            }
          },
          {
            "player": {
              "id": 289428,
              "name": "G. Nardelli",
              "number": 6,
              "pos": "D",
              "grid": "2:3"
            }
          },
          {
            "player": {
              "id": 30475,
              "name": "N. Paz",
              "number": 30,
              "pos": "D",
              "grid": "2:2"
            }
          },
          {
            "player": {
              "id": 119830,
              "name": "N. Banegas",
              "number": 3,
              "pos": "D",
              "grid": "2:1"
            }
          },
          {
            "player": {
              "id": 6147,
              "name": "A. Cardozo",
              "number": 5,
              "pos": "M",
              "grid": "3:1"
            }
          },
          {
            "player": {
              "id": 70841,
              "name": "B. Armoa",
              "number": 18,
              "pos": "M",
              "grid": "4:4"
            }
          },
          {
            "player": {
              "id": 59046,
              "name": "M. Garay",
              "number": 8,
              "pos": "M",
              "grid": "4:3"
            }
          },
          {
            "player": {
              "id": 6239,
              "name": "G. Maroni",
              "number": 10,
              "pos": "M",
              "grid": "4:2"
            }
          },
          {
            "player": {
              "id": 265912,
              "name": "T. Galván",
              "number": 20,
              "pos": "M",
              "grid": "4:1"
            }
          },
          {
            "player": {
              "id": 196743,
              "name": "F. Monzón",
              "number": 23,
              "pos": "F",
              "grid": "5:1"
            }
          }
        ]
      }
    ]
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Football Field Formation'),
      ),
      body:
       Center(
        child: CustomPaint(
          painter: FootballFieldPainter(),
          child: Stack(
            children: [
              Positioned(
                right: 0,
                child: Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Text(lineupData['lineups'][0]['formation']),
              )),
              Container(
                color: AppColors.primary1.withOpacity(.1),
                width: 360,
                height: 550,
                child: _buildFormation(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormation() {
    List<Widget> formationRows = [];
    var lineup = lineupData['lineups'][0];
    
      var formation =
          lineup['formation'].split('-').map((s) => int.parse(s)).toList();
      formation.insert(0, 1); // Add the goalkeeper row

      for (int i = 0; i < formation.length; i++) {
        formationRows.add(_buildRow(lineup['startXI'], i + 1, formation[i]));
      }
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: formationRows,
    );
  }

  Widget _buildRow(List<dynamic> players, int row, int count) {
    List<Widget> rowChildren = [];
    var rowPlayers = players
        .where((player) => player['player']['grid'].startsWith('$row:'))
        .toList();
    for (var player in rowPlayers) {
      rowChildren.add(_buildPlayer(player['player']));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: rowChildren,
    );
  }

  Widget _buildPlayer(Map<String, dynamic> playerInfo) {
    return Column(
      children: [
        CircleAvatar(
          radius: 20.0,
          backgroundColor: Color.fromARGB(255, 115, 137, 188),
          child: Text(
            playerInfo['number'].toString(),
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 5),
        Text(
          playerInfo['name'],
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ],
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
