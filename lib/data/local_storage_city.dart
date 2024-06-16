import 'package:shared_preferences/shared_preferences.dart';

class CityStorage {
  static const _keyCityList = 'city_list';

  Future<void> saveCityList(List<String> cities) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_keyCityList, cities);
  }

  Future<List<String>> getCityList() async {
    final prefs = await SharedPreferences.getInstance();
    final cityList = prefs.getStringList(_keyCityList) ?? [];
    return cityList;
  }
}