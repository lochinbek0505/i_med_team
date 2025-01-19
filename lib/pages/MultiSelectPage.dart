import 'package:flutter/material.dart';
import 'package:i_med_team/models/lesson_model.dart';
import 'package:i_med_team/pages/WritableQuestion.dart';
import 'package:i_med_team/pages/test_page.dart';

import '../models/end_model.dart';
import '../models/end_test_model.dart';
import '../services/ApiService.dart';
import 'MatchableQuestion.dart';
import 'TestResultPage.dart';

class MultiSelectPage extends StatefulWidget {
  num? index;
  num? score;

  LessonModel? data;

  num? course_id;
  num? module_id;
  num? lesson_id;

  MultiSelectPage({required this.index,
    required this.score,
    required this.data,
    required this.course_id,
    required this.module_id,
    required this.lesson_id});

  @override
  _MultiSelectPageState createState() => _MultiSelectPageState();
}

class _MultiSelectPageState extends State<MultiSelectPage> {
  String selectedAnswer = '';
  final String correctAnswer = 'Molekula';
  var check = false;
  late LessonModel quizModel;
  var index;
  var index2 = 0;
  var score;
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
  List<Answers> base = [];

  bool check_base(name) {
    for (var item in base) {
      if (item.value1 == name) {
        return true;
      }
    }
    return false;
  }

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
    if (base.isNotEmpty) {
      setState(() {
        check_correct = true;
      });

      // Wait for a specific duration (e.g., 3 seconds)
      await Future.delayed(Duration(seconds: 1));

      setState(() {
        var ch = true;

        for (var item in base) {
          if (!item.isCorrect!) {
            ch = false;
          }
        }

        if (ch) {
          score++;
        }

        if (quizModel.data!.quiz!.questionsList!.length > index + 1) {
          index++;

          print(score);
          switch (quizModel.data!.quiz!.questionsList![0].type) {
            case "one_select":
              {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuestionPage(
                        index: index,
                        score: score,
                        course_id: widget.course_id,
                        module_id: widget.module_id,
                        lesson_id: widget.lesson_id,
                        data: quizModel,
                      ),
                    ));
              }
            case "many_select":
              {
                calculate_prs();
                check_correct = false;
              }
            case "writable":
              {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WritableQuestion(
                        index: index,
                        course_id: widget.course_id,
                        module_id: widget.module_id,
                        lesson_id: widget.lesson_id,
                        score: score,
                        data: quizModel,
                      ),
                    ));
              }
            case "matchable":
              {
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
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Iltimos javobni tanlang !"),
      ));
    }
  }

  Future<void> end(EndTestModel model) async {
    _endLesson();
    _endTest(model);
  }

  void _endLesson() async {
    var data = await apiService.end_lesson(EndModel(
        course: widget.course_id,
        modul: widget.module_id,
        lesson: widget.lesson_id));
    if (data.status == "success") {}
  }

  void _endTest(EndTestModel model) async {
    var data = await apiService.end_test(EndTestModel(
      course: model.course,
      module: model.module,
      lesson: model.lesson,
      score: model.score,
      percent: model.percent,
    ));
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                  "${index + 1}/$len",
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
            Expanded(
              child: AbsorbPointer(
                absorbing: check_correct,
                child: ListView.builder(
                  itemCount: quizModel
                      .data!.quiz!.questionsList![index].answersList!.length,
                  itemBuilder: (context, index1) {
                    index2 = index1;
                    Answers answer = quizModel
                        .data!.quiz!.questionsList![index].answersList![index1];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (!check_base(answer.value1)) {
                            base.add(answer);
                          } else {
                            base.remove(answer);
                          }
                          selectedAnswer = answer.value1!;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Card(
                          elevation: 5,
                          child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: check_base(answer.value1) && check_correct
                                  ? (answer.isCorrect!
                                      ? Colors.green[100]
                                      : Colors.red[100])
                                  : Colors.white,
                              border: Border.all(
                                color:
                                    check_base(answer.value1) && check_correct
                                        ? (answer.isCorrect!
                                            ? Colors.green
                                            : Colors.red)
                                        : check_base(answer.value1)
                                            ? Colors.blue
                                            : Colors.white,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    answer.value1!,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                if (check_base(answer.value1) && check_correct)
                                  Icon(
                                    answer.isCorrect!
                                        ? Icons.check
                                        : Icons.close,
                                    color: answer.isCorrect!
                                        ? Colors.green
                                        : Colors.red,

                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            // Spacer(),
            Container(
              height: 55,
              child: ElevatedButton(
                style: Theme.of(context).elevatedButtonTheme.style,
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
    );
  }
}
