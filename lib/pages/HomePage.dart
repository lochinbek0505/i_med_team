import 'package:flutter/material.dart';
import 'package:i_med_team/pages/CoursesPage.dart';
import 'package:i_med_team/pages/MainPage.dart';
import 'package:i_med_team/pages/ProfilPage.dart';
import 'package:i_med_team/pages/RatePage.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;

  // List of pages to display
  final List<Widget> _pages = [
    Mainpage(),
    Coursespage(),
    CourseList(),
    ProfilePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/ic_home1.png',
              height: _selectedIndex == 0
                  ? 32
                  : 24, // Larger size for selected index
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/learning1.png',
              width: _selectedIndex == 1
                  ? 35
                  : 30, // Larger size for selected index
            ),
            label: 'Courses',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/ic_reward.png',
              height: _selectedIndex == 2
                  ? 32
                  : 25, // Larger size for selected index
            ),
            label: 'Rate',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/ic_user.png',
              height: _selectedIndex == 3
                  ? 32
                  : 26, // Larger size for selected index
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        // Highlighted tab index
        selectedItemColor: Colors.black,
        // White for active item
        unselectedItemColor: Colors.black,
        // Light white for inactive items
        backgroundColor: Colors.red[50],
        // Red background
        type: BottomNavigationBarType.fixed,
        // Fixed style
        iconSize: 28,
        // Icon size
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 1,
        ),
        // Bold, slightly larger font for active label
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 1,
        ),
        // Normal weight, smaller font for inactive label
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
