import 'package:flutter/material.dart';
import 'package:i_med_team/pages/HomePage.dart';
import 'package:i_med_team/pages/LoginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final token = await getToken();
  runApp(MyApp(
    isLogginIn: token != null,
  ));
}

Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('auth_token');
}

class MyApp extends StatelessWidget {
  final bool isLogginIn;

  const MyApp({super.key, required this.isLogginIn});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var check = getToken().toString();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      // home: LoginPage(),
      home: isLogginIn ? Homepage() : LoginPage(),
    );
  }
}
