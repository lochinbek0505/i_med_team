import 'package:flutter/material.dart';
import 'package:i_med_team/models/login_request.dart';
import 'package:i_med_team/pages/HomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/ApiService.dart';
import 'RegisterPage.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController phoneController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final ApiService apiService = ApiService('https://oztech.uz/api/v1');

  // Replace with your API URL
  bool isLoading = false;

  void handLogin() async {
    // var user=RegisterRequest(phone: , firstName: firstNameController.text, lastName: lastController.text, middleName: middleController.text, city: selectedRegion.toString(), town: selectedDistrict.toString(), password: passwordController.text);
    // var response=await apiService.register_request(user);

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

      if (success.status == 'success') {
        print("TOKEN TOKEN TOKEN TOKEN TOKEN TOKEN ${success.data.token}");
        saveToken(success.data.token);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login successful')),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Homepage()),
        ); // Navigator.pop(context);
        // Navigate to another page (e.g., HomePage)
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$success')),
        );
      }
    } catch (e) {
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

  @override
  void initState() {
    super.initState();
    super.initState();
    phoneController.addListener(() {
      if (!phoneController.text.startsWith("+998")) {
        // Force the prefix "+998"
        phoneController.text = "+998";
        phoneController.selection = TextSelection.fromPosition(
          TextPosition(offset: phoneController.text.length),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
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
          child: Container(
            height: 360,
            margin: EdgeInsets.symmetric(vertical: 20),
            child: Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0, left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Telefon raqamingiz',
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
                    SizedBox(height: 30),
                    isLoading
                        ? CircularProgressIndicator()
                        : Container(
                            width: size.width / 0.9,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.redAccent),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()),
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
    );
  }
}
