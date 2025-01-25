import 'package:flutter/material.dart';
import 'package:i_med_team/models/lesson_model.dart';
import 'package:i_med_team/pages/MatchableQuestion.dart';
import 'package:i_med_team/pages/test_page.dart';

import '../models/end_model.dart';
import '../models/end_test_model.dart';
import '../services/ApiService.dart';
import '../widgets/dialog.dart';
import 'MultiSelectPage.dart';
import 'TestResultPage.dart';

class WritableQuestion extends StatefulWidget {
  num? index;
  num? score;
  LessonModel? data;
  num? course_id;
  num? module_id;
  num? lesson_id;

  WritableQuestion(
      {required this.index,
      required this.score,
      required this.data,
      required this.course_id,
      required this.module_id,
      required this.lesson_id});

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
  final ApiService apiService = ApiService('https://oztech.uz/api/v1');

  void initialize() {
    quizModel = widget.data!;
  }

  var check_selecd = false;

  double prs = 0;

  // var
  var check_nom = 0;
  var check_correct = false;
var len;
  @override
  void initState() {
    super.initState();
    index = widget.index!.toInt();
    score = widget.score!.toInt();

    initialize();
    len = quizModel.data!.quiz!.questionsList!.length;

    calculate_prs();
  }

  void calculate_prs() {
    prs = (index + 1) / (len);
  }

  Future<void> button_click() async {
  if(controller.text.isNotEmpty){

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
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuestionPage(
                      index: index,
                      course_id: widget.course_id,
                      module_id: widget.module_id,
                      lesson_id: widget.lesson_id,
                      score: score,
                      data: quizModel,
                    ),
                  ));
            }
          case "many_select":
            {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MultiSelectPage(
                      index: index,
                      course_id: widget.course_id,
                      module_id: widget.module_id,
                      lesson_id: widget.lesson_id,
                      score: score,
                      data: quizModel,
                    ),
                  ));
            }
          case "matchable":{
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MatchableQuestion(
                    index: index,
                    course_id: widget.course_id,
                    module_id: widget.module_id,
                    lesson_id: widget.lesson_id,
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
        var percent = score / widget.data!.data!.quiz!.questionsList!.length;


        end(EndTestModel(
            course: widget.course_id,
            module: widget.module_id,
            lesson: widget.lesson_id,
            score: score,
            percent: percent));
        print(EndTestModel(
            course: widget.course_id,
            module: widget.module_id,
            lesson: widget.lesson_id,
            score: score,
            percent: percent));
      }
    });
  }
  else{
    ScaffoldMessenger.of(context)
        .showSnackBar(
        const SnackBar(
          content: Text(
              "Iltimos javobni kiriting !"),
        ));
  }
  }
  Future<void> end(EndTestModel model)async {
    LoadingDialog.show_dialog(context);

    _endLesson();
    _endTest(model);
  }

  void _endLesson() async {
    var data = await apiService.end_lesson(EndModel(
        course: widget.course_id,
        modul: widget.module_id,
        lesson: widget.lesson_id));
    if (data.status == "success") {

    }
  }
  void _endTest(EndTestModel model) async {
    var data = await apiService.end_test(EndTestModel(
      course: model.course,
      module: model.module,
      lesson: model.lesson,
      score: model.score,
      percent: model.percent,
    ));
    LoadingDialog.hide_dialog(context);
    if (data.status == "success") {

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => TestResultPage(
                  precent: (model.percent! * 100).toInt().toString(),
                  correct: model.score.toString(),
                  incorrect: (quizModel.data!.quiz!.questionsList!.length -
                      model.score!)
                      .toString())));

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[50],
      appBar: AppBar(
        // backgroundColor: Colors.redAccent,
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
                    "${index+1}/$len",
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
              Container(
                height: 55,
                child: ElevatedButton(
                  style:Theme.of(context).elevatedButtonTheme.style,
                  onPressed: !check_correct ? button_click : null,
                  child: Center(
                    child: Text(
                      'KEYINGISI',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
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
