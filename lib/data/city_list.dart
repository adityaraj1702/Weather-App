import 'package:flutter/material.dart';

class CityListProvider extends ChangeNotifier{

  final List<String> _cities = [
    "Varanasi",
    "Mumbai",
    "Delhi",
    "Kolkata",
  ];

  List<String> get cities => _cities;
  int selectedIndex = 0;
  void changeIndex(int index){
    selectedIndex = index;
    notifyListeners();
  }
  void addCity(String city){
    _cities.add(city);
    notifyListeners();
  }
  void addCityatIndex(String city, int index){
    _cities[index] = city;
    notifyListeners();
  }
  void removeCity(int index){
    _cities.removeAt(index);
    notifyListeners();
  }
}

class CityService {
  final CityListProvider cityListProvider;

  CityService(this.cityListProvider);

  void changeIndex(int index) {
    cityListProvider.changeIndex(index);
  }
  void addCityatIndex(String cityName, int index) {
    cityListProvider.addCityatIndex(cityName, index);
  }
  
  void addCity(String cityName) {
    cityListProvider.addCity(cityName);
  }

  void removeCity(int index) {
    cityListProvider.removeCity(index);
  }
}
