import 'package:flutter/material.dart';
import 'package:i_med_team/pages/AboutUsPage.dart';
import 'package:i_med_team/pages/CodeVerifyPage.dart';
import 'package:i_med_team/pages/HomePage.dart';
import 'package:i_med_team/pages/LoginPage.dart';
import 'package:i_med_team/pages/OnboardingPage.dart';
import 'package:i_med_team/services/ThemeManager.dart';
import 'package:i_med_team/services/ThemeProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final token = await getToken();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: MyApp(
        isLogginIn: token != null,
      )));
}

Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('auth_token');
}

class MyApp extends StatefulWidget {
  final bool isLogginIn;

  MyApp({super.key, required this.isLogginIn});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('check');
  }

  var checkk = true;
  var ch = "";

  @override
  void initState() {
    super.initState();
    getEmail().then((onValue) {
      checkk = onValue == null || onValue!.isEmpty;
      if (!checkk) {
        ch = onValue!;
      }
      print(checkk);
      print(onValue);
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var check = getToken().toString();
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Flutter Demo',

      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.themeMode,
      theme: ThemeManager.lightTheme,
      darkTheme: ThemeManager.darkTheme,
      // home: LoginPage(),
      home: !widget.isLogginIn
          ? checkk
              ? OnboardingScreen()
              : ch != "0"
                  ? CodeVerificationPage()
                  : LoginPage()
          : Homepage(),
    );
  }
}
