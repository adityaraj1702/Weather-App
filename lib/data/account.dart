import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/model/userdata_modal.dart';

class AccountStorage {
  static const _keyUsername = 'username';
  static const _keyEmail = 'email';
  static const _keyTempUnit = 'tempUnit';
  static const _keyWindSpeedUnit = 'windSpeedUnit';
  static const _keyThemeMode = 'themeMode';

  Future<void> saveStringData(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<String?> getStringData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<void> saveUserData(String username, String email, String tempUnit,
      String windSpeedUnit, String themeMode) async {
    await saveStringData(_keyUsername, username);
    await saveStringData(_keyEmail, email);
    await saveStringData(_keyTempUnit, tempUnit);
    await saveStringData(_keyWindSpeedUnit, windSpeedUnit);
    await saveStringData(_keyThemeMode, themeMode);
  }

  Future<UserData> getUserData() async {
    final username = await getStringData(_keyUsername) ?? 'User';
    final email = await getStringData(_keyEmail) ?? 'user@gmail.com';
    final tempUnit = await getStringData(_keyTempUnit) ?? 'C';
    final windSpeedUnit = await getStringData(_keyWindSpeedUnit) ?? 'km/h';
    final themeMode = await getStringData(_keyThemeMode) ?? 'default';
    return UserData(username, email, tempUnit, windSpeedUnit, themeMode);
  }
}
