import 'package:flutter/material.dart';
import 'package:i_med_team/models/lesson_model.dart';
import 'package:i_med_team/pages/MatchableQuestion.dart';
import 'package:i_med_team/pages/test_page.dart';

import 'MultiSelectPage.dart';

class WritableQuestion extends StatefulWidget {
  num? index;
  num? score;
  LessonModel? data;

  WritableQuestion(
      {required this.index, required this.score, required this.data});

  @override
  _WritableQuestionState createState() => _WritableQuestionState();
}

class _WritableQuestionState extends State<WritableQuestion> {
  String selectedAnswer = '';
  final String correctAnswer = 'Molekula';
  var check = false;
  late LessonModel quizModel;
  var index;
  var index2 = 0;
  var score;
  TextEditingController controller = TextEditingController();

  void initialize() {
    quizModel = widget.data!;
  }

  var check_selecd = false;

  double prs = 0;

  // var
  var check_nom = 0;
  var check_correct = false;

  @override
  void initState() {
    super.initState();
    index = widget.index!.toInt();
    score = widget.score!.toInt();
    initialize();
    calculate_prs();
  }

  void calculate_prs() {
    prs = (index + 1 / quizModel.data!.quiz!.questionsList!.length);
  }

  Future<void> button_click() async {
    setState(() {
      check_correct = true;
    });

    // Wait for a specific duration (e.g., 3 seconds)
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      if (quizModel
              .data!.quiz!.questionsList![index].answersList![index2].value1!
              .toLowerCase()
              .trim()
              .toString() ==
          controller.text.toLowerCase().trim()) {
        score++;
      }
      if (quizModel.data!.quiz!.questionsList!.length > index + 1) {
        index++;

        print(score);
        switch (quizModel.data!.quiz!.questionsList![index].type) {
          case "one_select":
            {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuestionPage(
                      index: index,
                      score: score,
                      data: quizModel,
                    ),
                  ));
            }
          case "many_select":
            {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MultiSelectPage(
                      index: index,
                      score: score,
                      data: quizModel,
                    ),
                  ));
            }
          case "matchable":{
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MatchableQuestion(
                    index: index,
                    score: score,
                    data: quizModel,
                  ),
                ));
          }
          case "writable":
            {
              calculate_prs();
              check_correct = false;
            }
        }
      } else {
        print(score);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Center(
          child: Text(
            'Matematikadan imtihon',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    child: Container(
                        width: 25,
                        height: 25,
                        child: Center(
                          child: Text(
                            "X",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        )),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: LinearProgressIndicator(
                      value: prs,
                      minHeight: 10,
                      borderRadius: BorderRadius.circular(15),
                      backgroundColor: Colors.grey[300],
                      color: Colors.redAccent,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "6/10",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                quizModel.data!.quiz!.questionsList![index].question.toString(),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 35),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                      colors: [Colors.purple.shade200, Colors.red.shade200],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: controller,
                    maxLines: 10,
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                    decoration: InputDecoration(
                      hintText: "Javobingizni kiriting ...",
                      hintStyle: TextStyle(color: Colors.grey.shade600),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.85),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                ),
              ), // Spacer(),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: !check_correct ? button_click : null,
                child: Center(
                  child: Text(
                    'KEYINGISI',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
