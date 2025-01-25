import 'package:flutter/material.dart';
import 'package:i_med_team/pages/SettingsPage.dart';
import 'package:lottie/lottie.dart';

import 'LoginPage.dart';

class Verifypage extends StatefulWidget {


  num id;
  Verifypage({super.key, required this.id});

  @override
  State<Verifypage> createState() => _VerifypageState();
}

class _VerifypageState extends State<Verifypage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Tasdiqlash",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: 270,
                height: 270,
                child: Lottie.asset('assets/anim/verify.json')),
            Text(
              "Ajoyib !",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                onPressed: () {
                if(widget.id==1) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => LoginPage()));
                }
                if(widget.id==2){
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => SettingsPage()));

                }

                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10),
                  child: Text("Davom etish"),
                )),
          ],
        ),
      ),
    );
  }
}
