import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:i_med_team/models/subject_model.dart';
import 'package:i_med_team/pages/SettingsPage.dart';
import 'package:i_med_team/widgets/SubjectWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/contact_model.dart';
import '../models/profile_model.dart';
import '../services/ApiService.dart';
import 'SubjectCoursesPage.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  final ApiService apiService =
      ApiService('https://oztech.uz/api/v1'); // Replace with your API URL
  late Future<SubjectModel> _itemsFuture;
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

  List<Subject50> items = [];
  List<Subject50> filteredItems = [];

  // Filtered list for search
  TextEditingController searchController =
      TextEditingController(); // Controller for search input
  void dispose() {
    searchController.dispose(); // Dispose of controller
    super.dispose();
  }

  Future<void> _refreshItems() async {
    _itemsFuture = apiService.subject_list(context);
    _itemsFuture.then((data) {
      setState(() {
        items = data.dataList!;
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

  Future<void> saveUserToPreferences(ProfileModel user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userJson = jsonEncode(user.toJson());
    await prefs.setString('user', userJson);
  }

  @override
  void initState() {
    super.initState();

    apiService.contact().then((contact){
      saveContactToPreferences(contact);
    });


    getUserFromPreferences().then((value) {
      setState(() {
        print(value!.data!.image);
        profil = value;
      });
    });

    // Fetch courses and subjects from the API
    _itemsFuture = apiService.subject_list(context);
    _itemsFuture.then((data) {
      setState(() {
        items = data.dataList!;
        filteredItems =
            List.from(items); // Initialize filteredItems with all items
      });
    }).catchError((error) {
      print('Error fetching courses: $error');
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
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(180),
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/ic_app_background.jpg"),
                    fit: BoxFit.cover)),
            child: Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 20),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (builder) => SettingsPage()));
                        },
                        child: Container(
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
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return CircularProgressIndicator(
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                        );
                                      },
                                      errorBuilder: (BuildContext context,
                                          Object exception,
                                          StackTrace? stackTrace) {
                                        return Image.asset(
                                            'assets/teacher.png'); // Default rasm
                                      },
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset("assets/teacher.png")
                              : Image.asset("assets/teacher.png"),
                        ),
                      ),
                    ),
                  ],
                ),
                profil != null
                    ? Text(
                        "Salom , ${decodeText(profil!.data!.firstName.toString())} ",
                        style: Theme.of(context).textTheme.titleLarge)
                    : Text("Salom ,  ",
                        style: Theme.of(context).textTheme.titleLarge),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: TextField(
                        controller: searchController,
                        onChanged: (value) {
                          _filterCourses(value);
                        },
                        decoration: InputDecoration(
                          hintText: 'Fan qidirish',
                          hintStyle: TextStyle(
                            color: Colors.black87,
                            fontSize: 17,
                          ),
                          prefixIcon: Icon(
                            Icons.search_outlined,
                            size: 30,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
      body: RefreshIndicator(
        onRefresh: _refreshItems,
        child: Column(
          children: [
            filteredItems.isEmpty
                ? Center(child: CircularProgressIndicator())
                : Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 15),
                      child: ListView.builder(
                          // Make it scroll horizontally
                          itemCount: filteredItems.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                            onTap: () {

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (builder) =>
                                            SubjectsCoursePage(
                                                data: filteredItems[index])));
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child: Subjectwidget(
                                  data: filteredItems[index],
                                ),
                              ),
                            );
                          }),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
