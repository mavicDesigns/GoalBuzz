import 'package:flutter/material.dart';
import 'package:truck/src/models/players_model.dart';

class OverViewPage extends StatefulWidget {
  final PlayerResponse playerResponse;

  const OverViewPage({Key? key, required this.playerResponse}) : super(key: key);

  @override
  State<OverViewPage> createState() => _OverViewPageState();
}

class _OverViewPageState extends State<OverViewPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: Column(
        children: [_buildDetailsCard(), _buildPositionCard('Central Midfielder')],
      ),
    );
  }

  Future<void> _onRefresh() async {
    await Future.delayed(Duration(seconds: 2));
  }

  Widget _buildPositionCard(String position) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Position",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Primary",
                        style: TextStyle(fontSize: 16, color: Color.fromRGBO(105, 240, 174, .7)),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        (position),
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 30),
                Expanded(
                  flex: 2,
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                    height: 270,
                    child: CustomPaint(
                      painter: FootballPitchPainter(
                        position: _getAbbreviatedPosition(position),
                        context: context,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildDetailCard('Appearances',
                widget.playerResponse.responseData[0].statistics[0].games!.appearences.toString()),
            const SizedBox(width: 10),
            _buildDetailCard('Goals',
                widget.playerResponse.responseData[0].statistics[0].goals!.total.toString()),
            const SizedBox(width: 10),
            _buildDetailCard('Assists',
                widget.playerResponse.responseData[0].statistics[0].goals!.assists.toString()),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailCard(String title, String value) {
    return Expanded(
      child: Container(
        height: 120,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .color!
                    .withOpacity(.5),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  String _getAbbreviatedPosition(String position) {
    switch (position.toLowerCase()) {
      case 'goalkeeper':
        return 'GK';
      case 'defender':
        return 'CB';
      case 'central midfielder':
        return 'CM';
      case 'attacker':
        return 'FW';
      case 'defensive midfielder':
        return 'DMF';
      default:
        return position;
    }
  }

  @override
  bool get wantKeepAlive => true;
}

class FootballPitchPainter extends CustomPainter {
  final String position;
  final BuildContext context;

  FootballPitchPainter({required this.position, required this.context});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Theme.of(context).cardTheme.color!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final pitchPaint = Paint()
      ..color = Theme.of(context).canvasColor
      ..style = PaintingStyle.fill;

    final pitchRect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(pitchRect, pitchPaint);

    canvas.drawLine(
        Offset(0, size.height / 2),
        Offset(size.width, size.height / 2),
        paint);

    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), size.width / 7, paint);

    canvas.drawRect(
        Rect.fromLTWH(size.height * 0.15, 0, size.height * 0.4, size.width * 0.2),
        paint);
    canvas.drawRect(
        Rect.fromLTWH(size.height * 0.15, size.height - (size.width * 0.2),
            size.height * 0.4, size.width * 0.2),
        paint);

    paintPosition(canvas, size);
  }

  void paintPosition(Canvas canvas, Size size) {
    Offset positionOffset;
    switch (position) {
      case 'GK':
        positionOffset = Offset(size.width / 2 - 15, size.height * 0.1);
        break;
      case 'CB':
        positionOffset = Offset(size.width / 2 - 15, size.height * 0.3);
        break;
      case 'DMF':
        positionOffset = Offset(size.width / 2 - 15, size.height * 0.45);
        break;
      case 'CM':
        positionOffset = Offset(size.width / 2 - 0, size.height * 0.4);
        break;
      case 'FW':
        positionOffset = Offset(size.width / 2 - 15, size.height * 0.8);
        break;
      default:
        positionOffset = Offset(size.width / 2 - 15, size.height / 2);
    }

    final positionPaint = Paint()
      ..color = Colors.redAccent
      ..style = PaintingStyle.fill;

    final rrect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: positionOffset, width: 50, height: 30),
      const Radius.circular(20),
    );
    canvas.drawRRect(rrect, positionPaint);

    final textPainter = TextPainter(
      text: TextSpan(
        text: position,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
        canvas, positionOffset - Offset(textPainter.width / 2, textPainter.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
