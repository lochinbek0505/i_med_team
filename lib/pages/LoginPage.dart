import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:i_med_team/models/login_request.dart';
import 'package:i_med_team/models/profile_model.dart';
import 'package:i_med_team/pages/CodeVerifyPage.dart';
import 'package:i_med_team/pages/HomePage.dart';
import 'package:i_med_team/pages/ProfessionPage.dart';
import 'package:i_med_team/pages/ResetPassword.dart';
import 'package:i_med_team/widgets/dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/ApiService.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController phoneController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final ApiService apiService = ApiService('https://oztech.uz/api/v1');
  double _passwordStrength = 0.0;

  Future<void> saveEmail(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', token);
  }

  // Replace with your API URL
  bool isLoading = false;

  void handLogin() async {
    // var user=RegisterRequest(phone: , firstName: firstNameController.text, lastName: lastController.text, middleName: middleController.text, city: selectedRegion.toString(), town: selectedDistrict.toString(), password: passwordController.text);
    // var response=await apiService.register_request(user);
    LoadingDialog.show_dialog(context);
    final phone = phoneController.text.trim();
    final password = passwordController.text.trim();

    if (phone.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Iltimos hamma maydonlarni to\'diring')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final user = LoginRequest(phone: phone, password: password);
      final success = await apiService.login_request(user);
      await saveEmail(phone);
      if (success.status == 'success') {
        print("TOKEN TOKEN TOKEN TOKEN TOKEN TOKEN ${success.data.token}");
        saveToken(success.data.token);

        var profile_data = await apiService.profile();
        await saveUserToPreferences(profile_data);
        LoadingDialog.hide_dialog(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Homepage()),
        ); // Navigator.pop(context);
        // Navigate to another page (e.g., HomePage)
      } else if (success.status == 'error' && success.code == "402") {
        LoadingDialog.hide_dialog(context);

        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Iltimos tasdiqlash kodini kiriting !")));
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (builder) => CodeVerificationPage()));
      } else {
        LoadingDialog.hide_dialog(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Xatolik iltimos qaytadan urinib ko\'ring')),
        );
      }
    } catch (e) {
      LoadingDialog.hide_dialog(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  void _checkPasswordStrength() {
    final password = passwordController.text;

    if (password.isEmpty) {
      setState(() {
        _passwordStrength = 0.0;
      });
      return;
    }

    double strength = 0.0;

    // Password length
    if (password.length >= 6) strength += 0.25;

    // Contains uppercase letter
    if (RegExp(r'[A-Z]').hasMatch(password)) strength += 0.25;

    // Contains number
    if (RegExp(r'[0-9]').hasMatch(password)) strength += 0.25;

    // Contains special character
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) strength += 0.25;

    setState(() {
      _passwordStrength = strength;
    });
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    super.initState();
    passwordController.addListener(_checkPasswordStrength);
  }

  Widget _buildStrengthIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(4, (index) {
        return Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            height: 10,
            decoration: BoxDecoration(
              color: index < _passwordStrength
                  ? (index < 2
                      ? Colors.red
                      : index == 2
                          ? Colors.orange
                          : Colors.green)
                  : Colors.grey[300],
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.redAccent,
        title: Center(
            child: Text(
          "Hisobga kirish",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              height: 550,
              margin: EdgeInsets.symmetric(vertical: 20),
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(top: 30.0, left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/onboard1.png",
                        height: 100,
                        width: 100,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "IMedTeam",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextField(
                        controller: phoneController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Emailingiz',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 25),
                      TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          labelText: 'Parolingiz',
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => ResetPasswordPage(
                                      check: true, title: "Parolni tiklash")));
                        },
                        child: Container(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            textAlign: TextAlign.end,
                            "Parolni unitdingizmi ?",
                            style: TextStyle(
                              color: Colors.lightBlue,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      // SizedBox(height: 6),
                      // _buildStrengthIndicator(),
                      SizedBox(height: 30),
                      isLoading
                          ? CircularProgressIndicator()
                          : Container(
                              width: size.width / 0.9,
                              height: 50,
                              child: ElevatedButton(
                                style: Theme.of(context).elevatedButtonTheme.style,
                                onPressed: handLogin,
                                child: Text(
                                  "Hisobga kirish",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 19),
                                ),
                              ),
                            ),
                      SizedBox(
                        height: 10,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfessionPage()),
                          );
                        },
                        child: Text(
                          "Ro'yxatdan o'tish",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<ProfileModel?> getUserFromPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');
    if (userJson != null) {
      Map<String, dynamic> userMap = jsonDecode(userJson);
      return ProfileModel.fromJson(userMap);
    }
    return null;
  }

  Future<void> saveUserToPreferences(ProfileModel user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userJson = jsonEncode(user.toJson());
    await prefs.setString('user', userJson);
  }
}
