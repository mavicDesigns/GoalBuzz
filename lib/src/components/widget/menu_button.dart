import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  final VoidCallback onPressed;

  MenuButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 12,
              height: 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              width: 20,
              height: 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              width: 12,
              height: 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}
