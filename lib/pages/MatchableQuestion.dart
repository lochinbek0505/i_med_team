import 'package:flutter/material.dart';
import 'package:i_med_team/models/end_test_model.dart';
import 'package:i_med_team/models/lesson_model.dart';
import 'package:i_med_team/pages/test_page.dart';

import '../models/end_model.dart';
import '../services/ApiService.dart';
import 'MultiSelectPage.dart';
import 'TestResultPage.dart';

class MatchableQuestion extends StatefulWidget {
  LessonModel data;
  int index;
  int score;

  num? course_id;
  num? module_id;
  num? lesson_id;

  MatchableQuestion({required this.index,
    required this.score,
      required this.data,
      required this.course_id,
      required this.module_id,
      required this.lesson_id});

  @override
  _MatchableQuestionState createState() => _MatchableQuestionState();
}

class _MatchableQuestionState extends State<MatchableQuestion> {
  late List<String> _questions;
  late List<String> _answers;
  String? _selectedQuestion;
  String? _selectedAnswer;
  final Map<String, String> _questionsToAnswers = {};
  late LessonModel quizModel;
  late double prs;
  late int index;
  final ApiService apiService = ApiService('https://oztech.uz/api/v1');
  late int score;
  var len=0;
  var check = true;

  void initilize() {
    quizModel = widget.data;
    widget.data.data!.quiz!.questionsList![index].answersList!.forEach((item) {
      _questionsToAnswers[item.value1!] = item.value2!;
    });
    print(_questionsToAnswers);
    len=widget.data.data!.quiz!.questionsList!.length;

    calculate_prs();
    _questions = _questionsToAnswers.keys.toList()..shuffle();
    _answers = _questionsToAnswers.values.toList()..shuffle();
  }

  @override
  void initState() {
    super.initState();
    score = widget.score!;
    index = widget.index!;

    initilize();
  }

  void calculate_prs() {
    prs=(index + 1) / (len);
  }

  Future<void> button_click() async {
    // Wait for a specific duration (e.g., 3 seconds)
    if(_questions.isEmpty && _answers.isEmpty){
      await Future.delayed(Duration(seconds: 1));

      setState(() {
        if (check) {
          score++;
        }
        if (quizModel.data!.quiz!.questionsList!.length > index + 1) {
          index++;

          switch (quizModel.data!.quiz!.questionsList![index].type) {
            case "one_select":
              {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuestionPage(
                        course_id: widget.course_id,
                        module_id: widget.module_id,
                        lesson_id: widget.lesson_id,
                        index: index,
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
            case "writable":
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

            case "matchable":
              {
                _questionsToAnswers.clear();
                initilize();
              }
          }
        } else {
          var percent = score / widget.data.data!.quiz!.questionsList!.length;

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
    }else{
      ScaffoldMessenger.of(context)
          .showSnackBar(
          const SnackBar(
            content: Text(
                "Iltimos hamma javoblarni tanlang !"),
          ));

    }
  }
  Future<void> end(EndTestModel model)async {
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

  void _checkMatch() {
    if (_selectedQuestion != null && _selectedAnswer != null) {
      final correctAnswer = _questionsToAnswers[_selectedQuestion!];
      // Show feedback for incorrect matches
      print(check);
      if (correctAnswer != _selectedAnswer) {
        print(check);
        check = false;
      }

      // Remove both items regardless of correctness
      setState(() {
        _questions.remove(_selectedQuestion);
        _answers.remove(_selectedAnswer);
        _selectedQuestion = null;
        _selectedAnswer = null;
      });
    }
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
            Expanded(
              child: Row(
                children: [
                  // Questions Column
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: _questions.length,
                            itemBuilder: (context, index) {
                              final question = _questions[index];
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedQuestion = question;
                                  });
                                  _checkMatch();
                                },
                                child: Card(
                                  color: _selectedQuestion == question
                                      ? Colors.teal.shade100
                                      : Colors.white,
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      question,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Answers Column
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: _answers.length,
                            itemBuilder: (context, index) {
                              final answer = _answers[index];
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedAnswer = answer;
                                  });
                                  _checkMatch();
                                },
                                child: Card(
                                  color: _selectedAnswer == answer
                                      ? Colors.teal.shade100
                                      : Colors.white,
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      answer,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (_questions.isEmpty)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  button_click();
                },
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
    );
  }
}
