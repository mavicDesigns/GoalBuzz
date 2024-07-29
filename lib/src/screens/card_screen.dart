import 'package:flutter/material.dart';
import 'package:truck/src/components/widget/card_component.dart';

class CustomCardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Card Component'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomCardComponent(
          header: Container(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Header',
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
          body: Container(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'This is the body of the card. It has a white background.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          footer: Container(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Footer',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          //headerColor: Colors.blueGrey[100]!, // Example header color
          borderRadius: 12.0,
          boxShadow: BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ),
      ),
    );
  }
}
