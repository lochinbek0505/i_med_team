import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:i_med_team/models/courses_list_model.dart';
import 'package:i_med_team/models/subject_model.dart';
import 'package:i_med_team/pages/CourseShowPage.dart';
import 'package:i_med_team/widgets/SubjectWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/contact_model.dart';
import '../models/profile_model.dart';
import '../services/ApiService.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  final ApiService apiService =
      ApiService('https://oztech.uz/api/v1'); // Replace with your API URL
  late Future<CoursesListModel> _itemsFuture;
  ProfileModel? profil;

  Future<ProfileModel?> getUserFromPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');
    if (userJson != null) {
      Map<String, dynamic> userMap = jsonDecode(userJson);
      return ProfileModel.fromJson(userMap);
    }
    return null;
  }

  late List<Data70> items;
  List<Data70> filteredItems = [];
  var subjects = [];
  late Future<SubjectModel> _subjects;

  // Filtered list for search
  TextEditingController searchController =
      TextEditingController(); // Controller for search input
  void dispose() {
    searchController.dispose(); // Dispose of controller
    super.dispose();
  }

  Future<void> _refreshItems() async {
    _itemsFuture = apiService.course_list();
    _itemsFuture.then((data) {
      setState(() {
        items = data.data!;
        filteredItems =
            List.from(items); // Initialize filteredItems with all items
      });
    }).catchError((error) {
      print('Error fetching courses: $error');
    });
  }

  Future<void> openTelegramWithPhone(String phone) async {
    final Uri url = Uri.parse('tg://resolve?phone=$phone');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch Telegram with phone: $phone';
    }
  }

  void getCourses(num id) async {
    if(id!=10000){
    var data = await apiService.subject_course_list(id);
      print(data.data![0].name);

      setState(() {
      items = data.data!;
      filteredItems = data.data!;
    });
    }
    else{
      _itemsFuture = apiService.course_list();
      _itemsFuture.then((data) {
        setState(() {
          items = data.data!;
          filteredItems =
              List.from(items); // Initialize filteredItems with all items
        });
      }).catchError((error) {
        print('Error fetching courses: $error');
      });
    }
  }

  Future<void> saveContactToPreferences(ContactModel user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userJson = jsonEncode(user.toJson());
    await prefs.setString('contact', userJson);
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

  void _filterCourses(String query) {
    setState(() {
      filteredItems = items
          .where(
              (item) => item.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();

    apiService.contact().then((contact){
      saveContactToPreferences(contact);
    });
    getUserFromPreferences().then((value) {
      setState(() {
        print(value!.data!.firstName);
        profil = value;
      });
    });

    // Fetch courses and subjects from the API
    _itemsFuture = apiService.course_list();
    _itemsFuture.then((data) {
      setState(() {
        items = data.data!;
        filteredItems =
            List.from(items); // Initialize filteredItems with all items
      });
    }).catchError((error) {
      print('Error fetching courses: $error');
    });

    // Fetch subjects separately
    apiService.subject_list().then((data) {
      setState(() {
        subjects = data.data;
        subjects.insert(0, Subject50(id: 10000, name: "Barcha kurslar"));
      });
    }).catchError((error) {
      print('Error fetching subjects: $error');
    });
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
      appBar: AppBar(
        // backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        // foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //
            profil != null
                ? Text(
                    "Salom , ${decodeText(profil!.data!.firstName.toString())} ",
                    style: Theme.of(context).textTheme.titleLarge)
                : Text("Salom ,  ",
                    style: Theme.of(context).textTheme.titleLarge),
            Container(
              width: 40,
              height: 40,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              //
              child: profil != null
                  ? profil!.data!.image != null
                      ? Image.network(
                          profil!.data!.image.toString(),
                          fit: BoxFit.cover,
                        )
                      : Image.asset("assets/teacher.png")
                  : Image.asset("assets/teacher.png"),
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshItems,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Card(
              color: Colors.white,
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Container(
                height: 60,
                child: Center(
                  child: TextField(
                    controller: searchController,
                    onChanged: (value) {
                      _filterCourses(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Kurs qidirish',
                      hintStyle: TextStyle(
                        color: Colors.black87,
                        fontSize: 17,
                      ),
                      prefixIcon: Image.asset(
                        'assets/ic_loupe.png',
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ),
            ),
            subjects.isEmpty
                ? CircularProgressIndicator()
                : Container(
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 15),
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          // Make it scroll horizontally
                          itemCount: subjects.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                            onTap: () {
                              getCourses(subjects[index].id);
                            },
                            child: Subjectwidget(
                              data: subjects[index],
                            ),
                          );
                        }),
              ),
            ),

            //courses ui

            Expanded(
              child: filteredItems.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: filteredItems.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 15),
                          child: Card(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CourseShowPage(
                                          id: filteredItems[index].id)),
                                );
                              },
                              child: Container(
                                width: 340,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 8,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Top Image Section
                                    ClipRRect(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(16)),
                                      child: Image.network(
                                        "${filteredItems[index].image}",
                                        height: 180,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(height: 8),

                                    // Course Info Section
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Students and Icon Row
                                    Row(
                                      children: [
                                        Icon(Icons.people,
                                            size: 20, color: Colors.black54),
                                        SizedBox(width: 4),
                                        Text(
                                          "${filteredItems[index]
                                              .countStudents} ta o'quvchi",
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),

                                          // Course Title
                                          Text(
                                            "${decodeText(filteredItems[index].name!)} ",
                                            maxLines: 1,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 4),

                                          // Course Description
                                    Text(
                                      maxLines: 3,
                                            decodeText(filteredItems[index]
                                                .description!),
                                            style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 14,
                                            ),
                                    ),
                                    const SizedBox(height: 10),

                                          // Teacher Name and Rating
                                          Row(
                                            children: [
                                              Text(
                                                "${decodeText(filteredItems[index].user!.firstName!)} ${decodeText(filteredItems[index].user!.lastName!)}",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(height: 12),

                                    // Bottom Price and Button Row
                                    Container(
                                      padding: const EdgeInsets.all(12.0),
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.vertical(
                                          bottom: Radius.circular(16),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${filteredItems[index].price} so'm",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.orange,
                                              fontSize: 18,
                                            ),
                                          ),
                                          !filteredItems[index].isOpen!
                                              ? ElevatedButton(
                                                  onPressed: () async {
                                                    var contact =
                                                        await getContactFromPreferences();
                                                    print(contact!.data!.phone);
                                                    openTelegramWithPhone(
                                                        contact!.data!.phone!);
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.orange,
                                                    foregroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            child: const Text("Kursni olish"),
                                                )
                                              : SizedBox(),
                                        ],
                                      ),
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
          ],
        ),
      ),
    );
  }
}
