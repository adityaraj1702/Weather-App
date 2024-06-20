import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/data/city_data_list_provider.dart';
import 'package:weather_app/data/city_list.dart';
import 'package:weather_app/data/local_storage_city.dart';
import 'package:weather_app/model/citydata_model.dart';
import 'package:weather_app/model/weather_service.dart';
import 'package:weather_app/model/weathermodel.dart';
import 'package:weather_app/screens/home_screen.dart';
import 'package:weather_app/utlis/colors.dart';
import 'package:weather_app/utlis/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<List<dynamic>> fetchData() async {
    List<String> cityList = await CityStorage().getCityList();
    List<dynamic> data = [];
    for (int i = 0; i < cityList.length; i++) {
      WeatherService weatherService = WeatherService();
      List pos = cityList[i].split(":");
      print("fetching weather for ${pos[0]}:${pos[1]}");
      data.add(await weatherService.fetchWeatherData(pos[0], pos[1]));
    }
    return data;
  }
  // Future<void> navigateToHomeDelayed() async {
  //   await Future.delayed(
  //       const Duration(milliseconds: 500)); // Adjust delay as needed
  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(builder: (context) => HomeScreen(data: [])),
  //   );
  // }


  @override
  void initState() {
    super.initState();
    fetchData().then((data) {
      // final cityDataListProvider =
      //     Provider.of<CityDataListProvider>(context, listen: false);
      // // Update CityDataListProvider with fetched data
      // for (var item in data) {
      //   cityDataListProvider.cityDataList.add(item);
      // }

      // Update CityListProvider if needed (assuming cityList is updated)
      final cityListProvider =
          Provider.of<CityListProvider>(context, listen: false);
      CityStorage().saveCityList(
          cityListProvider.cities.map((e) => "${e.lat}:${e.lon}").toList());

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => HomeScreen(data: data)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [splash_bgColortop, splash_bgColorbottom],
          ),
        ),
        child: Center(
          child: Image.asset(
            applogo,
            width: 150,
            height: 150,
          ),
        ),
      ),
    );
  }
}
