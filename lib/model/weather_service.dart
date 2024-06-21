import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class WeatherService{

  Future<Map<String, dynamic>> fetchWeatherData(String lat, String lon) async {
    try {
      final apikey = dotenv.env['API_KEY'];
      final url = Uri.parse(
          'http://api.weatherapi.com/v1/forecast.json?key=$apikey&q=${lat},${lon}&aqi=yes');
      final response = await http.get(url);
      print(response.statusCode);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("data recieved!");
        return data;
        // notifyListeners(); // Notify UI about changes
      } else {
        // Handle error (e.g., display an error message)
        throw PlatformException(
            message: 'Failed to fetch weather data', code: '');
      }
    } catch (e) {
      // Handle exceptions (e.g., location permission denied)
      rethrow;
    }
  }
}