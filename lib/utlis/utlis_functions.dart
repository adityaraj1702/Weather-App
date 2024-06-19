import 'package:geolocator/geolocator.dart';

class MyFucntions {
  Future<Position> getCurrentLocation() async {
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      await Geolocator.requestPermission();
      // return null;
    }
    LocationPermission locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied ||
        locationPermission == LocationPermission.deniedForever) {
      locationPermission = await Geolocator.requestPermission();
    }
    Position currPos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(currPos);
    return currPos;
  }
  void updateWeatherData(var data){
    
  }
}