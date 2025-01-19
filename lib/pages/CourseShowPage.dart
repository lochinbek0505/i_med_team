import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:i_med_team/models/lesson_model.dart';
import 'package:i_med_team/models/show_courses_model.dart';
import 'package:i_med_team/pages/LessonsPage.dart';
import 'package:i_med_team/pages/MultiSelectPage.dart';
import 'package:i_med_team/pages/test_page.dart';
import 'package:i_med_team/widgets/CourseInformationWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/contact_model.dart';
import '../services/ApiService.dart';
import 'MatchableQuestion.dart';
import 'WritableQuestion.dart';

class CourseShowPage extends StatefulWidget {
  final num? id;

  CourseShowPage({super.key, this.id});


  void test(){

    print(id);

  }
  @override
  State<CourseShowPage> createState() => _CourseShowPageState();
}

class _CourseShowPageState extends State<CourseShowPage> {
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
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    String message = "Welcome to the First Page!";

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Sahifaga qaytganingizda ishlaydi
      final args = ModalRoute.of(context)?.settings.arguments as String?;
      if (args != null) {
        setState(() {
          message = args;
          _refreshItems();

          // Natija asosida sahifani yangilash
        });
      }
    });
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
         await Navigator.push(
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
                settings: const RouteSettings(arguments: "New message from Second Page!"),

              ));
        }
      case "many_select":
        {
         await Navigator.push(
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

  String decodeText(String text) {
    try {
      return utf8.decode(text.runes.toList());
    } catch (e) {
      return text; // Xato bo‘lsa, asl matn qaytariladi
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Colors.grey[50],
      appBar: AppBar(
        // backgroundColor: Colors.redAccent,
        title: Center(
          child: Text(
            "KURS HAQIDA",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
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

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 15),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          data.image, // Replace with your image URL
                          height: 220,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        decodeText(data.name),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text(
                        decodeText(data.description),
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 15),
                      child: Text(
                        "O'qituvchi : ",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.network(
                              data.user.image ?? "",
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "${data.user.firstName} ${data.user.lastName}",
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Star Icon
                              Icon(
                                Icons.person,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text(
                                "${data.countStudents}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              // Coin Icon with Text
                            ],
                          ),
                          Row(
                            children: [
                              Image.asset(
                                'assets/dollar.png',
                                // Replace with the path to your coin image asset
                                height: 24,
                                width: 24,
                              ),
                              SizedBox(width: 7),
                              // Spacing between icon and text
                              Text(
                                '${data.price} so\'m',
                                style: TextStyle(
                                  color: Colors.orange,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    CourseInformationWidget(
                      icon: "assets/lesson.png",
                      text: "${data.countLessons} ta video dars",
                    ),
                    CourseInformationWidget(
                      icon: "assets/video_lesson.png",
                      text:
                          "${(data.length / 60).toInt()} soat ${data.length % 60} min",
                    ),
                    CourseInformationWidget(
                      icon: "assets/test.png",
                      text: "${data.countQuizzes} ta test topshirig'i",
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 7),
                      child: Text(
                        "Kurs tarkibi : ",
                        style: TextStyle(
                          fontSize: 21,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(color: Colors.black, width: 2.0),
                              // Top border
                              left: BorderSide(color: Colors.black, width: 2.0),
                              // Left border
                              right: BorderSide(color: Colors.black, width: 2)),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40),
                            topLeft: Radius.circular(40),
                          ),
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          // Ensures ListView takes only required space
                          physics: NeverScrollableScrollPhysics(),
                          // Disable ListView's scrolling

                          itemCount: data.modules.length,
                          itemBuilder: (context, sectionIndex) {
                            final section = data.modules[sectionIndex];
                            print(section.lessons.length);

                            if (true) {
                              // Expandable Section
                              return Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Theme(
                                    data: ThemeData().copyWith(
                                        dividerColor: Colors.transparent),
                                    child: ExpansionTile(
                                      initiallyExpanded: sectionIndex == 0,
                                      // First section expanded by default
                                      title: Text(
                                        section.name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),

                                      children: List.generate(
                                        section.lessons.length,
                                        (index) {
                                          final item = section.lessons[index];
                                          var isOpen = false;
                                          print(
                                              "${data.isOpen}+${data.modules[0].isOpen}+${data.modules[0].lessons[0].isOpen}");
                                          // section.isOpen &&
                                          if (section.isOpen && data.isOpen) {
                                            isOpen = item.isOpen;
                                          }
                                          return GestureDetector(
                                            onTap: () async {
                                              // section.isOpen &&
                                              if (data.isOpen &&
                                                  item.isOpen &&
                                                  section.isOpen) {
                                                if (item.type == "lesson") {

                                                 await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            LessonsPage(
                                                                course_id:
                                                                    widget.id!,
                                                                modul_id:
                                                                    section.id,
                                                                lesson_id:
                                                                    item.id),
                                                        settings: const RouteSettings(arguments: "New message from Second Page!"),
                                                 ),
                                                  );
                                                } else if (item.type ==
                                                    "quiz") {
                                                  quiz_navigation(
                                                      course_id: widget.id!,
                                                      modul_id: section.id,
                                                      lesson_id: item.id);
                                                }
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        const SnackBar(
                                                  content: Text(
                                                      "Iltimos avval admin bilan bo'glanib kursga qo'shiling."),
                                                ));
                                              }
                                            },
                                            child: ListTile(
                                              leading: Icon(
                                                  isOpen
                                                      ? Icons.play_circle
                                                      : Icons.lock,
                                                  color: isOpen
                                                      ? Colors.green
                                                      : Colors.amber),
                                              title: Text(
                                                item.name,
                                                style: TextStyle(
                                                  fontSize: 17,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Divider(
                                    thickness: 2,
                                    height: 1,
                                    color: Colors.black,
                                  )
                                ],
                              );
                            } else {
                              // Non-expandable Section
                              return ListTile(
                                title: Text(
                                  section.name,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                trailing: Icon(Icons.add),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                    !data.isOpen
                        ? Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Container(
                        height: 55,
                        width: size.width,
                        child: ElevatedButton(
                                style:
                                    Theme.of(context).elevatedButtonTheme.style,
                                onPressed: () async {
                                  var contact =
                                      await getContactFromPreferences();
                                  print(contact!.data!.phone);
                                  openTelegramWithPhone(contact!.data!.phone!);
                                },
                                child: Text(
                                  "KURSNI XARID QILISH",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                        ),
                      ),
                          )
                        : SizedBox(),
                  ],
                );
              }
            }),
      ),
    );
  }

  Future<void> openTelegramWithPhone(String phone) async {
    final Uri url = Uri.parse('tg://resolve?phone=$phone');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch Telegram with phone: $phone';
    }
  }

  Future<ContactModel?> getContactFromPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('contact');
    if (userJson != null) {
      Map<String, dynamic> userMap = jsonDecode(userJson);
      return ContactModel.fromJson(userMap);
    }
    return null;
  }
}
