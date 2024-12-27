import 'package:flutter/material.dart';

class Subjectwidget extends StatelessWidget {
  Subjectwidget({super.key, this.name});

  var name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      // Add spacing between buttons
      child: Card(
        elevation: 5,
        color: Colors.white,
        child: Container(
          height: 40,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(name),
            ),
          ),
        ),
      ),
    );
  }
}
