import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:i_med_team/models/lesson_model.dart';
import 'package:i_med_team/pages/HomePage.dart';
import 'package:i_med_team/pages/LoginPage.dart';
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

class MyApp extends StatelessWidget {
  final bool isLogginIn;

  MyApp({super.key, required this.isLogginIn});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var check = getToken().toString();
    LessonModel data;

    var json = """
{
    "status": "success",
    "code": "200",
    "data": {
        "id": 4,
        "name": "test",
        "type": "quiz",
        "video": null,
        "duration": 0,
        "resource": null,
        "quiz": {
            "id": 1,
            "name": "Ona tili",
            "questions": [
                
                {
                    "question": "oxirgi usul",
                    "type": "matchable",
                    "answers": [
                        {
                            "value_1": "1",
                            "value_2": "2",
                            "is_correct": false
                        },
                        {
                            "value_1": "3",
                            "value_2": "4",
                            "is_correct": false
                        },
                        {
                            "value_1": "5",
                            "value_2": "6",
                            "is_correct": false
                        }
                    ]
                },
                 {
                    "question": "oxirgi usul",
                    "type": "matchable",
                    "answers": [
                        {
                            "value_1": "ww",
                            "value_2": "wer",
                            "is_correct": false
                        },
                        {
                            "value_1": "q",
                            "value_2": "w",
                            "is_correct": false
                        },
                        {
                            "value_1": "a",
                            "value_2": "b",
                            "is_correct": false
                        }
                    ]
                }
           
           
            ]
        },
        "previous": {
            "id": 3,
            "name": "1-dars",
            "type": "lesson",
            "duration": 50,
            "is_open": true
        },
        "next": null,
        "is_open": true,
        "created": "2025-01-05T16:51:03.924704Z"
    }
}

    """;

    var map = jsonDecode(json);
    data = LessonModel.fromJson(map);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Flutter Demo',

      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.themeMode,
      theme: ThemeManager.lightTheme,
      darkTheme: ThemeManager.darkTheme,
      // home: LoginPage(),
      home: isLogginIn ? Homepage() : LoginPage(),
    );
  }

  ThemeData _lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: Colors.redAccent,
        // Asosiy rang (Yorqin qizil)
        secondary: Colors.redAccent,
        // Ikkinchi darajali rang
        surface: Colors.white,
        // Orqa fon rangi (Oq fon)
        onSurface: Colors.black,
        // Matn rangi
        onPrimary: Colors.white,
        // Asosiy rangdagi matn rangi (Oq)
        onSecondary: Colors.white, // Ikkinchi darajali matn
      ),
      scaffoldBackgroundColor: Colors.grey[50], // Fon rangi (Kulrang)
    );
  }

  // Tungi rejim uchun custom ranglar palitrasi
  ThemeData _darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: Colors.red[900]!,
        // Asosiy rang (Qorong'iroq qizil)
        secondary: Colors.red[800]!,
        // Ikkinchi darajali rang
        surface: Colors.grey[850]!,
        // Orqa fon rangi (Qorong'iroq kulrang)
        onSurface: Colors.white,
        // Matn rangi (Oq)
        onPrimary: Colors.white,
        // Asosiy rangdagi matn rangi (Oq)
        onSecondary: Colors.white, // Ikkinchi darajali matn
      ),
      scaffoldBackgroundColor: Colors.grey[900]!, // Tungi fon
    );
  }
}
