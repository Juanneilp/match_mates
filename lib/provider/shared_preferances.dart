import 'package:flutter/material.dart';
import 'package:match_mates/service/preferences_helper.dart';

class PreferancesProvider extends ChangeNotifier {
  PrefencesHelper prefencesHelper;
  PreferancesProvider({required this.prefencesHelper}) {
    _getTheme();
  }

  bool _isDarkTheme = false;
  bool get isDarktheme => _isDarkTheme;

  //provider for getting shared preferance

  void _getTheme() async {
    _isDarkTheme = await prefencesHelper.isDarkTheme;
    notifyListeners();
  }

  //provider for eneble shared preferance
  void enebleDarkTheme(bool value) {
    prefencesHelper.setDarkTheme(value);
    _getTheme();
  }
}
