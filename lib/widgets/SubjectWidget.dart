import 'package:flutter/material.dart';
import 'package:i_med_team/models/subject_model.dart';

class Subjectwidget extends StatelessWidget {
  Subjectwidget({super.key, required this.data});

  Subject data;

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
              child: Text(data.name),
            ),
          ),
        ),
      ),
    );
  }
}
