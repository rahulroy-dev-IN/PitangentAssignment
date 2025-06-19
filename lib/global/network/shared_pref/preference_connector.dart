import 'package:shared_preferences/shared_preferences.dart';

class PreferenceConnector {
  _getSharedPreference() async {
    return await SharedPreferences.getInstance();
  }

  Future<String?> getString(String key) async {
    SharedPreferences prefs = await _getSharedPreference();
    return prefs.getString(key);
  }

  Future<int?> getInt(String key) async {
    SharedPreferences prefs = await _getSharedPreference();
    return prefs.getInt(key);
  }

  Future<double?> getDouble(String key) async {
    SharedPreferences prefs = await _getSharedPreference();
    return prefs.getDouble(key);
  }

  Future<bool?> getBool(String key) async {
    SharedPreferences prefs = await _getSharedPreference();
    return prefs.getBool(key);
  }

  Future<List<String>?> getStringList(String key) async {
    SharedPreferences prefs = await _getSharedPreference();
    return prefs.getStringList(key);
  }

  Future setString(String key, String value) async {
    SharedPreferences prefs = await _getSharedPreference();
    prefs.setString(key, value);
  }

  void setInt(String key, int value) async {
    SharedPreferences prefs = await _getSharedPreference();
    prefs.setInt(key, value);
  }

  void setDouble(String key, double value) async {
    SharedPreferences prefs = await _getSharedPreference();
    prefs.setDouble(key, value);
  }

  void setBool(String key, bool value) async {
    SharedPreferences prefs = await _getSharedPreference();
    prefs.setBool(key, value);
  }

  Future setStringList(String key, List<String> value) async {
    SharedPreferences prefs = await _getSharedPreference();
    await prefs.setStringList(key, value);
  }

  void removePreference(String key) async {
    SharedPreferences prefs = await _getSharedPreference();
    prefs.remove(key);
  }

  void clear() async {
    SharedPreferences prefs = await _getSharedPreference();
    prefs.clear();
  }
}
