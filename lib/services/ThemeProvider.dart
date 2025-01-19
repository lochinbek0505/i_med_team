import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light; // Default rejim kunduzgi
  static const String _themeKey = 'isDarkMode'; // Saqlash uchun kalit

  ThemeProvider() {
    _loadTheme(); // Ilovani ishga tushirishda saqlangan rejimni yuklash
  }

  // Joriy mavzuni olish
  ThemeMode get themeMode => _themeMode;

  // Rejimni almashtirish va saqlash
  void toggleTheme(bool isDarkMode) async {
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners(); // UI-ni yangilash uchun xabar berish

    // Tanlangan rejimni mahalliy xotirada saqlash
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, isDarkMode);
  }

  // Mahalliy xotirada saqlangan rejimni yuklash
  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool(_themeKey) ?? false; // Default rejim: kunduzgi
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners(); // UI-ni yangilash uchun xabar berish
  }
}
