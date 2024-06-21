import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/data/city_data_list_provider.dart';
import 'package:weather_app/data/city_list.dart';
import 'package:weather_app/data/local_storage_city.dart';
import 'package:weather_app/model/citydata_model.dart';
import 'package:weather_app/model/weather_service.dart';
import 'package:weather_app/screens/home_screen.dart';
import 'package:weather_app/utlis/utlis_functions.dart';
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

  @override
  void initState() {
    super.initState();
    fetchData().then((data) async {
      if (data.length == 0) {
        Position pos = await MyFucntions().getCurrentLocation();
        data.add(await WeatherService().fetchWeatherData(
            pos.latitude.toString(), pos.longitude.toString()));
      }
      // Update CityDataListProvider with fetched data
      int i=0;
      for (var item in data) {
        Provider.of<CityDataListProvider>(context, listen: false).addCity(item);
        // Update CityListProvider if needed (assuming cityList is updated)
        CityData cityData = CityData(
          city: item['location']['name'].toString(),
          lat: item['location']['lat'].toString(),
          lon: item['location']['lon'].toString(),
          tempC: item['current']['temp_c'].toString(),
          maxtempC:
              item['forecast']['forecastday'][0]['day']['maxtemp_c'].toString(),
          mintempC:
              item['forecast']['forecastday'][0]['day']['mintemp_c'].toString(),
          avgtempC:
              item['forecast']['forecastday'][0]['day']['avgtemp_c'].toString(),
          tempF: item['current']['temp_f'].toString(),
          maxtempF:
              item['forecast']['forecastday'][0]['day']['maxtemp_f'].toString(),
          mintempF:
              item['forecast']['forecastday'][0]['day']['mintemp_f'].toString(),
          avgtempF:
              item['forecast']['forecastday'][0]['day']['avgtemp_f'].toString(),
          feelslikeC: item['current']['feelslike_c'].toString(),
          feelslikeF: item['current']['feelslike_f'].toString(),
          localtime: item['location']['localtime'].toString(),
          weatherCondition: item['current']['condition']['text'].toString(),
          windSpeedKph: item['current']['wind_kph'].toString(),
          windSpeedMph: item['current']['wind_mph'].toString(),
          humidity: item['current']['humidity'].toString(),
          aqi: item['current']['air_quality']['pm2_5'].toString(),
          chanceofrain: item['forecast']['forecastday'][0]['day']
                  ['daily_chance_of_rain']
              .toString(),
        );
        i!=0?Provider.of<CityListProvider>(context, listen: false).addCity(cityData): Provider.of<CityListProvider>(context, listen: false).changeCityatIndex(cityData, i);
        
        i++;
      }
      CityStorage().saveCityList(Provider.of<CityListProvider>(
        context,
        listen: false,
      ).cities.map((e) => "${e.lat}:${e.lon}").toList());
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
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
