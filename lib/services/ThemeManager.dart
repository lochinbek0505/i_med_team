import 'package:flutter/material.dart';

class ThemeManager {
  // Kunduzgi mavzu
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.red,
    scaffoldBackgroundColor: Colors.grey.shade200,
    // Asosiy fon rangi

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.red, // AppBar fon rangi
      foregroundColor: Colors.white, // Matn rangi
      elevation: 4, // AppBar soyasi
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor: Colors.white, // Drawer fon rangi
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        // Tugma foni rangi
        foregroundColor: Colors.white, // Matn rangi
        textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              10), // Set the corner radius
        ),
      ),
    ), // bottomNavigationBarTheme: BottomNavigationBarThemeData(
    //  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    //   backgroundColor: Colors.white, // NavigationBar fon rangi
    //   selectedItemColor: Colors.redAccent, // Tanlangan element rangi
    //   unselectedItemColor: Colors.grey, // Tanlanmagan element rangi
    //   elevation: 8, // Soha balandligi
    // ),
  );

  // Tungi mavzu
  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade400, // Asosiy fon rangi
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xff5a0202), // AppBar fon rangi
      foregroundColor: Colors.white, // Matn rangi
      elevation: 4, // AppBar soyasi
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor: Colors.grey.shade400, // Drawer fon rangi
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xff5a0202), // Tugma foni rangi
        foregroundColor: Colors.white, // Matn rangi
        textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              10), // Set the corner radius
        ),
      ),
    ), // bottomNavigationBarTheme: BottomNavigationBarThemeData(
    //   backgroundColor: Colors.grey[850], // NavigationBar fon rangi
    //   selectedItemColor: Colors.redAccent, // Tanlangan element rangi
    //   unselectedItemColor: Colors.white70, // Tanlanmagan element rangi
    //   elevation: 8, // Soha balandligi
    //
    // ),
  );
}
