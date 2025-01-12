import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:i_med_team/models/lesson_model.dart';
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
