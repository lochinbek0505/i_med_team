import 'dart:convert';

import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:i_med_team/pages/CoursesPage.dart';
import 'package:i_med_team/pages/MainPage.dart';
import 'package:i_med_team/pages/RatePage.dart';
import 'package:i_med_team/pages/SettingsPage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/contact_model.dart';
import '../models/profile_model.dart';
import '../services/ApiService.dart';
import '../services/ThemeProvider.dart';
import 'OnboardingPage.dart';
import 'ProfilPage.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;
  final ApiService apiService =
      ApiService('https://oztech.uz/api/v1'); // Replace with your API URL
  ProfileModel? profil;
  var isDay = true;
  // List of pages to display
  final List<Widget> _pages = [
    Mainpage(),
    ReytingPage(),
    ProfilePage(),
    SettingsPage(),
    // ProfilePage()
  ];

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

  Future<ProfileModel?> getUserFromPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');
    if (userJson != null) {
      Map<String, dynamic> userMap = jsonDecode(userJson);
      return ProfileModel.fromJson(userMap);
    }
    return null;
  }
  Future<void> clearSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
  @override
  void initState() {
    super.initState();

    apiService.contact().then((contact) {
      saveContactToPreferences(contact);
    });

    getUserFromPreferences().then((value) {
      setState(() {
        print(value!.data!.firstName);
        profil = value;
      });
    });
  }
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Hisobdan chiqish !"),
          content: Text("Hisobdan chiqishni xohlaysizmi ?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Bekor qilish"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                clearSharedPreferences();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => OnboardingScreen()));
                print("User logged out");
              },
              child: Text("Hisobdan chiqish"),
            ),
          ],
        );
      },
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  String decodeText(String text) {
    try {
      return utf8.decode(text.runes.toList());
    } catch (e) {
      return text; // Xato bo‘lsa, asl matn qaytariladi
    }
  }

  Widget _appBar(index) {
    switch (index) {
      case 0:
        {
          return Row(
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
          );
        }

      case 1:
        {
          return Text(
            "Peshqadamlar",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          );
        }
      case 2:
        {
          return Text(
            "Profil",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          );
        }
    }

    return Text("IMedTeam");
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      // appBar: AppBar(
      // backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: _appBar(_selectedIndex),
      ),
      drawer: Drawer(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        child: Column(
          children: [
            DrawerHeader(
                decoration: BoxDecoration(
                  color: themeProvider.themeMode == ThemeMode.dark
                      ? Color(0xff5a0202)
                      : Colors.redAccent,
                ),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.white,
                              backgroundImage: profil!.data!.image != null
                                  ? NetworkImage(
                                      profil!.data!.image.toString(),
                                    )
                                  : AssetImage(
                                      "assets/teacher.png"), // Placeholder
                            ),
                            GestureDetector(
                              onTap: () {
                                isDay =
                                    themeProvider.themeMode == ThemeMode.dark;
                                setState(() {
                                  isDay = !isDay;
                                  themeProvider.toggleTheme(isDay);
                                });
                              },
                              child: AnimatedSwitcher(
                                duration: Duration(milliseconds: 800),
                                transitionBuilder: (child, animation) {
                                  return SlideTransition(
                                    position: Tween<Offset>(
                                      begin: Offset(0.0, 1.0),
                                      // Start from below
                                      end:
                                          Offset(0.0, 0.0), // End at the center
                                    ).animate(animation),
                                    child: FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    ),
                                  );
                                },
                                child: Icon(
                                  themeProvider.themeMode == ThemeMode.dark
                                      ? Icons.sunny
                                      : Icons.nightlight,
                                  color: Colors.white,
                                  key: ValueKey<bool>(isDay),
                                  size: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          '${profil!.data!.firstName} ${profil!.data!.lastName}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   Column(
                     children: [
                       ListTile(
                         leading: Image.asset(
                           'assets/ic_home1.png',
                           height: 22, // Larger size for selected index
                         ),
                         title: Text('Home'),
                         onTap: () {
                           Navigator.pop(context);
                           setState(() {
                             _selectedIndex = 0;
                           });
                         },
                       ),
                       ListTile(
                         leading:  Image.asset(
                           'assets/ic_reward.png',
                           height: 22, // Larger size for selected index
                         ),
                         title: Text('Rating'),
                         onTap: () {
                           Navigator.pop(context);
                           setState(() {
                             _selectedIndex = 1;
                           });
                         },
                       ),
                       ListTile(
                         leading:  Image.asset(
                           'assets/ic_user.png',
                           height: 22, // Larger size for selected index
                         ),
                         title: Text('Profile'),
                         onTap: () {
                           Navigator.pop(context);
                           setState(() {
                             _selectedIndex = 2;
                           });
                         },
                       ),
                     ],
                   ),
                    Column(
                      children: [

                        ListTile(
                          leading:  Icon(Icons.settings),
                          title: Text('Settings'),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(context, MaterialPageRoute(builder: (builder)=>SettingsPage()));
                          },
                        ),
                        ListTile(
                          leading:  Image.asset(
                            'assets/logout 1.png',
                            height: 22, // Larger size for selected index
                          ),
                          title: Text('Hisobdan chiqish'),
                          onTap: () {
                            _showLogoutDialog(context);
                          },
                        ),
                        SizedBox(height: 10,),
                      ],
                    )
                  ],
                ),
              
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        items: [
          CurvedNavigationBarItem(
            child: Image.asset(
              'assets/ic_home1.png',
              height: _selectedIndex == 0
                  ? 30
                  : 24, // Larger size for selected index
            ),
            label: 'Home',
          ),
          // CurvedNavigationBarItem(
          //   child: Image.asset(
          //     'assets/learning1.png',
          //     width: _selectedIndex == 1
          //         ? 32
          //         : 30, // Larger size for selected index
          //   ),
          //   label: 'Courses',
          // ),
          CurvedNavigationBarItem(
            child: Image.asset(
              'assets/ic_reward.png',
              height: _selectedIndex == 2
                  ? 30
                  : 25, // Larger size for selected index
            ),
            label: 'Rating',
          ),
          CurvedNavigationBarItem(
            child: Image.asset(
              'assets/ic_user.png',
              height: _selectedIndex == 3
                  ? 30
                  : 26, // Larger size for selected index
            ),
            label: 'Profile',
          ),
          // CurvedNavigationBarItem(
          //   child: Icon(Icons.perm_identity),
          //   label: 'Personal',
          // ),
          //
          // BottomNavigationBarItem(
          //   icon: Image.asset(
          //     'assets/ic_home1.png',
          //     height: _selectedIndex == 0
          //         ? 32
          //         : 24, // Larger size for selected index
          //   ),
          //   label: '',
          // ),
          // BottomNavigationBarItem(
          //   icon:
          //   label: 'Courses',
          // ),
          // BottomNavigationBarItem(
          //   icon:
          // ,
          //   label: 'Rate',
          // ),
          // BottomNavigationBarItem(
          //   icon:
          //  ,
          //   label: 'Profile',
          // ),
        ],
        color: themeProvider.themeMode == ThemeMode.dark
            ? Colors.grey.shade100
            : Colors.white,
        buttonBackgroundColor: themeProvider.themeMode == ThemeMode.dark
            ? Colors.grey[100]
            : Colors.white,
        backgroundColor: themeProvider.themeMode == ThemeMode.dark
            ? Colors.grey.shade400
            : Colors.grey.shade100,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        letIndexChange: (index) => true,
        onTap: (index) {
          setState(() {
            _selectedIndex = index; // Update selected tab
          });
        },
      ),
      body: _pages[_selectedIndex],
    );
  }
}
