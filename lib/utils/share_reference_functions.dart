import 'package:shared_preferences/shared_preferences.dart';

Future<bool> saveStringToLocal(String key, String value) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
    return true;
  } catch (err) {
    print("SaveStringToLocal has error: ${err}");
    return false;
  }
}

Future<String> getStringFromLocal(String key) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? "";
  } catch (err) {
    print("SaveStringToLocal has error: ${err}");
    return "";
  }
}
