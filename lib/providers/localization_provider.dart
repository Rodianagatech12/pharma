import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationProvider with ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  Future<void> changeLanguage(String langCode) async {
    _locale = Locale(langCode);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', langCode);
    notifyListeners();
  }

  Future<void> loadLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? langCode = prefs.getString('language_code');
    // _locale = Locale(langCode);
  }
}
