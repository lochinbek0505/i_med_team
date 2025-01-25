import 'package:flutter/material.dart';
import 'package:i_med_team/pages/CodeVerifyPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/ApiService.dart';

class ResetPasswordPage extends StatefulWidget {
  String title;

  bool check;

  ResetPasswordPage({super.key, required this.check, required this.title});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  TextEditingController email_controller = TextEditingController();

  TextEditingController password_controller = TextEditingController();

  TextEditingController re_password_controller = TextEditingController();
  final ApiService apiService =
      ApiService('https://oztech.uz/api/v1'); // Replace with your API URL

  Future<void> saveEmail(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', token);
  }

  Future<void> saveCheck(String check) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString("check", check);
  }
  Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  Future<void> savePassword(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('pass', token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 10,
              ),
              widget.check
                  ? Text(
                      'Emailni kiriting',
                      style: TextStyle(fontSize: 16),
                    )
                  : SizedBox(),
              widget.check ? SizedBox(height: 8) : SizedBox(),
              widget.check
                  ? TextField(
                      controller: email_controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        hintText: 'Emailingizni kiriting',
                      ),
                      keyboardType: TextInputType.emailAddress,
                    )
                  : SizedBox(),
              const SizedBox(height: 16),
              const Text(
                'Yangi parolni kiriting',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: password_controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Yangi parol',
                  // hintText: 'Yangi parolingizni kiriting',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              const Text(
                'Yangi parolni tasdiqlang',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: re_password_controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Parolni tasdiqlash',
                  // hintText: 'Yangi parolingizni qaytadan kiriting',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  if (widget.check) {
                    if (email_controller.text.isNotEmpty &&
                        password_controller.text.isNotEmpty &&
                        re_password_controller.text.isNotEmpty) {
                      if (password_controller.text ==
                          re_password_controller.text) {
                        await saveEmail(email_controller.text);
                        await savePassword(password_controller.text);
                        var data =
                            await apiService.resend_code(email_controller.text);
                        if (data.status == 'success') {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) =>
                                      CodeVerificationPage()));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Parollar mos emas !")));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text("Iltimos hamma maydonlarni to'ldiring !")));
                    }
                  } else {
                    if (password_controller.text.isNotEmpty &&
                        re_password_controller.text.isNotEmpty) {
                      if (password_controller.text ==
                          re_password_controller.text) {
                        await savePassword(password_controller.text);
                        var email = await getEmail();
                        var data = await apiService.resend_code(email!);
                        if (data.status == 'success') {
                          saveCheck("2");
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) =>
                                      CodeVerificationPage()));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Parollar mos emas !")));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text("Iltimos hamma maydonlarni to'ldiring !")));
                    }
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: const Text('Tasdiqlash'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
