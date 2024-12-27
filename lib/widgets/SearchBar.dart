import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Container(
        height: 60,
        child: Center(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Kurs qidirish',
              hintStyle: TextStyle(
                color: Colors.black87,
                fontSize: 17,
              ),
              prefixIcon: Image.asset(
                'assets/ic_loupe.png',
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ),
      ),
    );
  }
}
