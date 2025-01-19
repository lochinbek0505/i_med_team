import 'package:flutter/material.dart';
import 'package:i_med_team/models/lesson_model.dart';
import 'package:i_med_team/models/my_lessons_tr_model.dart';
import 'package:i_med_team/models/show_courses_model.dart';
import 'package:i_med_team/pages/LessonsPage.dart';
import 'package:i_med_team/pages/MatchableQuestion.dart';
import 'package:i_med_team/pages/MultiSelectPage.dart';
import 'package:i_med_team/pages/WritableQuestion.dart';
import 'package:i_med_team/pages/test_page.dart';

import '../services/ApiService.dart';

class ShowMyLessons extends StatefulWidget {
  final num? id;

  ShowMyLessons({super.key, this.id});

  void test() {
    print(id);
  }

  @override
  State<ShowMyLessons> createState() => _ShowMyLessonsState();
}

class _ShowMyLessonsState extends State<ShowMyLessons> {
  final ApiService apiService =
      ApiService('https://oztech.uz/api/v1'); // Replace with your API URL
  late Future<ShowCoursesModel> _itemsFuture;

  late List<Data> items;

  @override
  void initState() {
    super.initState();
    _itemsFuture = apiService.course_detailes(widget.id!);
    _refreshItems();
  }

  Future<void> _refreshItems() async {
    setState(() {
      _itemsFuture = apiService
          .course_detailes(widget.id!); // Re-fetch items when refreshing
    });
  }

  void quiz_navigation(
      {required num course_id,
      required num modul_id,
      required num lesson_id}) async {
    LessonModel data =
        await apiService.show_lesson(course_id, modul_id, lesson_id);

    switch (data.data!.quiz!.questionsList![0].type) {
      case "one_select":
        {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QuestionPage(
                  index: 0,
                  score: 0,
                  course_id: course_id,
                  module_id: modul_id,
                  lesson_id: lesson_id,
                  data: data,
                ),
              ));
        }
      case "many_select":
        {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MultiSelectPage(
                  index: 0,
                  score: 0,
                  course_id: course_id,
                  module_id: modul_id,
                  lesson_id: lesson_id,
                  data: data,
                ),
              ));
        }
      case "writable":
        {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WritableQuestion(
                  index: 0,
                  score: 0,
                  course_id: course_id,
                  module_id: modul_id,
                  lesson_id: lesson_id,
                  data: data,
                ),
              ));
        }

      case "matchable":
        {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MatchableQuestion(
                  index: 0,
                  score: 0,
                  course_id: course_id,
                  module_id: modul_id,
                  lesson_id: lesson_id,
                  data: data,
                ),
              ));
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Colors.grey[50],
      appBar: AppBar(
        // backgroundColor: Colors.redAccent,
        title: Text(
          "KURS HAQIDA",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: FutureBuilder(
          future: _itemsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData ||
                snapshot.data!.data.modules.isEmpty) {
              return const Center(child: Text('No items found.'));
            } else {
              var data = snapshot.data!.data;

              List<MyLessonsTrModel> items = [];

              for (var value in data.modules) {
                for (var value1 in value.lessons) {
                  bool opened = false;
                  if (value.isOpen) {
                    opened = value1.isOpen;
                  }

                  items
                      .add(MyLessonsTrModel(value1, value1.id.toInt(), opened));
                }
              }

              print(items);
              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  var item = items[index];

                  // Expandable Section
                  return GestureDetector(
                    onTap: () {
                      if (item.isOpened!) {
                        if (item.lesson!.type == "lesson") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LessonsPage(
                                    course_id: widget.id!,
                                    modul_id: item.id!.toInt(),
                                    lesson_id: item.lesson!.id)),
                          );
                        } else if (item.lesson!.type == "quiz") {
                          quiz_navigation(
                              course_id: widget.id!,
                              modul_id: item.id!.toInt(),
                              lesson_id: item.lesson!.id);
                        }
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content:
                              Text("Iltimos avval oldingi darslarni tugating."),
                        ));
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 10,right: 10,top: 10),
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Colors.grey,
                                width: 2,
                              )),
                          child: ListTile(
                            leading: Icon(
                              item.lesson!.type == "lesson"
                                  ? Icons.play_circle_outline_outlined
                                  : Icons.question_mark_outlined,
                              color: Colors.green,
                              size: 35,
                            ),
                            title: Text(
                              item.lesson!.name,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 19,
                              ),
                            ),
                            trailing: Icon(
                                item.isOpened!
                                    ? Icons.check_circle_outline
                                    : Icons.lock,
                                size: 35,
                                color: item.isOpened!
                                    ? Colors.amber
                                    : Colors.amber),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          }),
    );
  }
}
