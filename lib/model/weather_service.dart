import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/env/api.dart';
import 'package:weather_app/model/weathermodel.dart';
import 'package:flutter/material.dart';

class WeatherService with ChangeNotifier {
  WeatherModel? _weatherData;
  // City? _city;

  Future<WeatherModel> fetchWeatherData(Position position) async {
    try {
      print(position);
      final url = Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=$openweathermapAPI&units=metric');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _weatherData = WeatherModel.fromJson(data);
        print("data recieved!");
        return _weatherData!;
        // print(_weatherData!.name.toString());
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

  WeatherModel? get weatherData => _weatherData;
  // City? get city => _city;
}
