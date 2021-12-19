import 'package:shared_preferences/shared_preferences.dart';

class PrefencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  PrefencesHelper({required this.sharedPreferences});

  // ignore: constant_identifier_names
  static const DARKTHEME = 'DARKTHEME';

  //shared preferences getting data from dark theme
  Future<bool> get isDarkTheme async {
    final prefs = await sharedPreferences;
    return prefs.getBool(DARKTHEME) ?? false;
  }

//sharef preferences setting data from dark theme
  void setDarkTheme(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(DARKTHEME, value);
  }
}
