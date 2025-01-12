import 'package:flutter/material.dart';
import 'package:i_med_team/models/lesson_model.dart';
import 'package:i_med_team/pages/test_page.dart';

import 'MultiSelectPage.dart';

class MatchableQuestion extends StatefulWidget {
  LessonModel data;
  int index;
  int score;

  MatchableQuestion(
      {super.key,
      required this.data,
      required this.index,
      required this.score});

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

  late int score;

  var check = true;

  void initilize() {
    quizModel = widget.data;
    widget.data.data!.quiz!.questionsList![index].answersList!.forEach((item) {
      _questionsToAnswers[item.value1!] = item.value2!;
    });
    print(_questionsToAnswers);
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
    prs = (index + 1 / quizModel.data!.quiz!.questionsList!.length);
  }

  Future<void> button_click() async {
    // Wait for a specific duration (e.g., 3 seconds)
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
          case "writable":
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

          case "matchable":
            {
              _questionsToAnswers.clear();
              initilize();
            }
        }
      } else {
        print(score);
      }
    });
  }

  void _checkMatch() {
    if (_selectedQuestion != null && _selectedAnswer != null) {
      final correctAnswer = _questionsToAnswers[_selectedQuestion!];
      // Show feedback for incorrect matches
      if (correctAnswer != _selectedAnswer) {
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
