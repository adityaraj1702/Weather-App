import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class CitySearchService{
  Future<List<Map<String, dynamic>>> fetchWeatherData(String location) async {
    try {
      final apikey = dotenv.env['API_KEY'];
      final url = Uri.parse(
          'http://api.weatherapi.com/v1/search.json?key=$apikey&q=$location');
      final response = await http.get(url);
      print(response.statusCode);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List<dynamic>;
        print("search data recieved! $data");
        final cities =
            data.map((cityData) => cityData as Map<String, dynamic>).toList();
            print("cities :$cities");
        return cities;
        // notifyListeners(); // Notify UI about changes
      } else {
        // Handle error (e.g., display an error message)
        throw PlatformException(
            message: 'Failed to fetch search data', code: '');
      }
    } catch (e) {
      // Handle exceptions (e.g., location permission denied)
      rethrow;
    }
  }
}