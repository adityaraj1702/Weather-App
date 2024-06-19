import 'package:flutter/material.dart';
import 'package:weather_app/model/citydata_model.dart';

class CityListProvider extends ChangeNotifier{

  List<CityData> cities = [
    CityData(
      city: "Ranchi(Default)",
      lat: "23.35",
      lon: "85.33",
      tempC: "38",
      maxtempC: "40",
      mintempC: "35",
      avgtempC: "38",
      tempF: "38",
      maxtempF: "40",
      mintempF: "35",
      avgtempF: "38",
      feelslikeC: "38",
      feelslikeF: "92",
      localtime: "2024-06-19 15:12",
      weatherCondition: "Clear",
      windSpeedKph: "28 Km/h",
      windSpeedMph: "28 Km/h",
      humidity: "34",
      aqi: "50",
      chanceofrain: "50",
    ),
  ];

  int selectedIndex = 0;
  void changeIndex(int index){
    selectedIndex = index;
    notifyListeners();
  }
  void addCity(CityData city){
    cities.add(city);
    notifyListeners();
  }
  void changeCityatIndex(CityData city, int index){
    cities[index] = city;
    notifyListeners();
  }
  void removeCityAtIndex(int index){
    cities.removeAt(index);
    notifyListeners();
  }
}