import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/data/city_list.dart';
import 'package:weather_app/data/local_storage_city.dart';
import 'package:weather_app/model/citydata_model.dart';
import 'package:weather_app/model/weather_service.dart';
import 'package:weather_app/model/weathermodel.dart';
import 'package:weather_app/utlis/colors.dart';
import 'package:weather_app/utlis/constants.dart';
import 'package:weather_app/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<List<dynamic>> checkCityStorage() async {
    List<String> cityList = await CityStorage().getCityList();
    CityListProvider cityListProvider = Provider.of<CityListProvider>(
      context,
      listen: false,
    );
    if (cityList.isEmpty) {
      CityStorage().saveCityList([
        "${cityListProvider.cities[0].lat}:${cityListProvider.cities[0].lon}"
      ]);
    }
    // WeatherDataProvider weatherDataProvider = Provider.of<WeatherDataProvider>(
    //   context,
    //   listen: false,
    // );
    List<dynamic> data = [];
    for (int i = 0; i < cityList.length; i++) {
      WeatherService weatherService = WeatherService();
      List pos = cityList[i].split(":");
      print("provider is being updated ${pos[0]}:${pos[1]}");
      data.add(await weatherService.fetchWeatherData(pos[0], pos[1]));
      CityData cityData = CityData(
        city: data[i]['location']['name'].toString(),
        lat: data[i]['location']['lat'].toString(),
        lon: data[i]['location']['lon'].toString(),
        tempC: data[i]['current']['temp_c'].toString(),
        maxtempC:
            data[i]['forecast']['forecastday'][0]['day']['maxtemp_c'].toString(),
        mintempC:
            data[i]['forecast']['forecastday'][0]['day']['mintemp_c'].toString(),
        avgtempC:
            data[i]['forecast']['forecastday'][0]['day']['avgtemp_c'].toString(),
        tempF: data[i]['current']['temp_f'].toString(),
        maxtempF:
            data[i]['forecast']['forecastday'][0]['day']['maxtemp_f'].toString(),
        mintempF:
            data[i]['forecast']['forecastday'][0]['day']['mintemp_f'].toString(),
        avgtempF:
            data[i]['forecast']['forecastday'][0]['day']['avgtemp_f'].toString(),
        feelslikeC: data[i]['current']['feelslike_c'].toString(),
        feelslikeF: data[i]['current']['feelslike_f'].toString(),
        localtime: data[i]['location']['localtime'].toString(),
        weatherCondition: data[i]['current']['condition']['text'].toString(),
        windSpeedKph: data[i]['current']['wind_kph'].toString(),
        windSpeedMph: data[i]['current']['wind_mph'].toString(),
        humidity: data[i]['current']['humidity'].toString(),
        aqi: data[i]['current']['air_quality']['pm2_5'].toString(),
        chanceofrain: data[i]['forecast']['forecastday'][0]['day']
                ['daily_chance_of_rain']
            .toString(),
      );
      if(i==0) {
        cityListProvider.changeCityatIndex(cityData,0);
      } else {
        cityListProvider.addCity(cityData);
      }
      print(cityListProvider.cities);
    }
    CityStorage().saveCityList(cityListProvider.cities.map((e) => "${e.lat}:${e.lon}").toList()); 
    print("updated citylist with ${cityListProvider.cities.length} entries");
    return data;
  }

  @override
  void initState() {
    super.initState();
    checkCityStorage().then((data) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen(data: data,)));
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
