import 'package:flutter/material.dart';

class CityDataListProvider extends ChangeNotifier{
  List<dynamic> cityDataList = [];
  
  int selectedIndex = 0;
  void changeIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  void addCity(dynamic cityData) {
    cityDataList.add(cityData);
    notifyListeners();
  }

  void changeCityatIndex(dynamic cityData, int index) {
    cityDataList[index] = cityData;
    notifyListeners();
  }

  void removeCityAtIndex(int index) {
    cityDataList.removeAt(index);
    notifyListeners();
  }
}