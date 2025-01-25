import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:i_med_team/models/verfy_model.dart';
import 'package:i_med_team/pages/RegisterPage.dart';
import 'package:i_med_team/pages/VerifyPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/ApiService.dart';
import '../widgets/dialog.dart';

class CodeVerificationPage extends StatefulWidget {
  @override
  _CodeVerificationPageState createState() => _CodeVerificationPageState();
}

class _CodeVerificationPageState extends State<CodeVerificationPage> {
  final List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());
  int _currentIndex = 0;
  int secondsRemaining = 30;
  final ApiService apiService =
      ApiService('https://oztech.uz/api/v1'); // Replace with your API URL

  bool enableResend = true;
  late Timer timer;
  List code = [];

  void _onKeyTap(String value) {
    if (_currentIndex < 4) {
      setState(() {
        check = true;
      });
      _controllers[_currentIndex].text = value;
      setState(() {
        _currentIndex++;
      });
      code.add(value);
      print(code);
    }
  }

  Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  Future<String?> getPassword() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('pass');
  }

  Future<String?> getCheck() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('check');
  }

  Future<void> saveEmail(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', token);
  }

  Future<void> saveCheck(String check) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString("check", check);
  }

  void _onDeleteTap() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        code.remove(_controllers[_currentIndex].text);
        setState(() {
          check = true;
        });
        _controllers[_currentIndex].clear();
        print(code);
      });
    }
  }

  //
  // void recount() {
  //   timer = Timer.periodic(Duration(seconds: 1), (_) {
  //     if (secondsRemaining != 0) {
  //       setState(() {
  //         secondsRemaining--;
  //       });
  //     } else {
  //       setState(() {
  //         enableResend = false;
  //       });
  //     }
  //   });
  // }
  var email = "";
  var correct = false;
  var check = true;
  var ch = "";
  var id = "";

  @override
  initState() {
    super.initState();
    getEmail().then((value) {
      setState(() {
        email = value!;
      });
    });
    getCheck().then((onValue) {
      ch = onValue != null ? onValue : "";
      if (ch.isNotEmpty) {
        id = onValue!;
      }
      ;
    });
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          enableResend = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: ch.isNotEmpty
            ? GestureDetector(
                onTap: () async {
                  await saveEmail("");
                  await saveCheck("");
                  Navigator.push(context,
                      MaterialPageRoute(builder: (builder) => RegisterPage()));
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Emailni tahrirlash",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              )
            : Text("Emailni tahrirlash"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          child: Text(
                            "Tasdiqlash",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "$email emailiga yuborilgan tasdiqlash kodini kiriting !",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        SizedBox(height: 35),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(4, (index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  color: check
                                      ? correct
                                          ? Colors.green
                                          : Colors.black54
                                      : Colors.red,
                                )),
                                width: 50,
                                child: TextField(
                                  controller: _controllers[index],
                                  enabled: false,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          LoadingDialog.show_dialog(context);

                          if (code.length == 4) {
                            var cod = "";
                            for (var value in code) {
                              cod += value;
                            }
                            var body = await apiService.verfy_code(
                                VerfyModel(email: email, code: int.parse(cod)));
                            print(body);
                            if ("200" == body.code) {
                              LoadingDialog.hide_dialog(context);

                              sleep(const Duration(seconds: 1));
                              var password = await getPassword();
                              setState(() {
                                correct = true;
                              });
                              if (ch.isNotEmpty) {
                                if (ch == "1") {
                                  LoadingDialog.hide_dialog(context);

                                  saveCheck("0");
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (builder) => Verifypage(
                                                id: 1,
                                              )));
                                } else {
                                  var code = await apiService.reset_password(
                                      email, password);
                                  LoadingDialog.hide_dialog(context);

                                  if (code.status == 'success') {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) =>
                                                Verifypage(id: 2)));
                                  }
                                }
                              } else {
                                var code = await apiService.reset_password(
                                    email, password);
                                LoadingDialog.hide_dialog(context);

                                if (code.status == 'success') {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (builder) =>
                                              Verifypage(id: 1)));
                                }
                              }
                            } else if (body.code == "404") {
                              LoadingDialog.hide_dialog(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text("Kiritilgan kod xato !")));

                              setState(() {
                                check = false;
                              });
                            }
                          } else {
                            LoadingDialog.hide_dialog(context);

                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Iltimos kodni to'liq kiritng")));
                          }
                        },
                        child: Text("Tasdiqlash"),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    enableResend
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Qayta yuborish",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                secondsRemaining < 10
                                    ? "0:0${secondsRemaining}"
                                    : "0:$secondsRemaining",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                        : GestureDetector(
                            onTap: () async {
                              var data = await apiService.resend_code(email);

                              print(data);
                              if (data.code == "200") {
                                setState(() {
                                  check = true;
                                  secondsRemaining = 30;
                                  enableResend = true;
                                  // recount();
                                });
                                // _controllers.forEach((controller) {
                                //   controller;
                                // });
                                // _currentIndex = 0;
                              }
                            },
                            child: Text(
                              "Kodni qayta yuborish",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                _buildCustomKeyboard(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCustomKeyboard() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: ["1", "2", "3"].map((e) => _buildKey(e)).toList(),
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: ["4", "5", "6"].map((e) => _buildKey(e)).toList(),
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: ["7", "8", "9"].map((e) => _buildKey(e)).toList(),
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(width: 60), // Empty space for alignment
            _buildKey("0"),
            IconButton(
              icon: Icon(Icons.backspace),
              onPressed: _onDeleteTap,
              iconSize: 40,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildKey(String value) {
    return GestureDetector(
      onTap: () => _onKeyTap(value),
      child: Container(
        width: 60,
        height: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[300],
        ),
        child: Text(
          value,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
