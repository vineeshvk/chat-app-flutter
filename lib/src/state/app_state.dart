import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState extends ChangeNotifier {
  AppState() {
    findTheme();
  }

  Future findTheme() async {
    final pref = await SharedPreferences.getInstance();
    final dark = pref.getBool("dark") ?? false;
    final tokenP = pref.getString('token') ?? "";
    if (tokenP != "") _token = tokenP;
    if (dark)
      setDark();
    else
      setLight();
  }

  String _token = "";
  ThemeData currentTheme = ThemeData(fontFamily: "Rubik");

  void setToken(String val) {
    _token = val;
    notifyListeners();
  }

  void setDark() {
    currentTheme = ThemeData(fontFamily: 'Rubik', brightness: Brightness.dark);
    notifyListeners();
  }

  void setLight() {
    currentTheme = ThemeData(fontFamily: 'Rubik', brightness: Brightness.light);
    notifyListeners();
  }

  void toggleTheme() {
    currentTheme = ThemeData(
      fontFamily: 'Rubik',
      brightness: currentTheme.brightness == Brightness.dark
          ? Brightness.light
          : Brightness.dark,
    );
    notifyListeners();
  }

  String get token => _token;
}
