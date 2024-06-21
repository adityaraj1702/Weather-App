import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/data/city_data_list_provider.dart';
import 'package:weather_app/data/city_list.dart';
import 'package:weather_app/data/local_storage_city.dart';
import 'package:weather_app/model/citydata_model.dart';
import 'package:weather_app/model/weather_service.dart';
import 'package:weather_app/screens/account_setting_screen.dart';
import 'package:weather_app/screens/manage_cities_screen.dart';
import 'package:weather_app/utlis/colors.dart';
import 'package:weather_app/utlis/constants.dart';
import 'package:weather_app/utlis/utlis_functions.dart';
import 'package:weather_app/widgets/city_weather.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key,});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MyFucntions func = MyFucntions();
  Position? currentPosition;
  List<Color> themes = [splash_bgColortop, splash_bgColorbottom];
  Color textColor = Colors.black;
  bool showIndicator = false;
  
  void getCurrentLocationWeather() async {
    currentPosition = await func.getCurrentLocation();
    print("current position: $currentPosition");
    getcurrentWeather(currentPosition!.latitude.toString(),
        currentPosition!.longitude.toString());
  }

  void getcurrentWeather(String lat, String lon) async {
    WeatherService weatherService = WeatherService();
    print("current position: $lat,$lon");
    var data = await weatherService.fetchWeatherData(lat, lon);
    print(data);
    CityData cityData = CityData(
      city: data['location']['name'].toString(),
      lat: data['location']['lat'].toString(),
      lon: data['location']['lon'].toString(),
      tempC: data['current']['temp_c'].toString(),
      maxtempC:
          data['forecast']['forecastday'][0]['day']['maxtemp_c'].toString(),
      mintempC:
          data['forecast']['forecastday'][0]['day']['mintemp_c'].toString(),
      avgtempC:
          data['forecast']['forecastday'][0]['day']['avgtemp_c'].toString(),
      tempF: data['current']['temp_f'].toString(),
      maxtempF:
          data['forecast']['forecastday'][0]['day']['maxtemp_f'].toString(),
      mintempF:
          data['forecast']['forecastday'][0]['day']['mintemp_f'].toString(),
      avgtempF:
          data['forecast']['forecastday'][0]['day']['avgtemp_f'].toString(),
      feelslikeC: data['current']['feelslike_c'].toString(),
      feelslikeF: data['current']['feelslike_f'].toString(),
      localtime: data['location']['localtime'].toString(),
      weatherCondition: data['current']['condition']['text'].toString(),
      windSpeedKph: data['current']['wind_kph'].toString(),
      windSpeedMph: data['current']['wind_mph'].toString(),
      humidity: data['current']['humidity'].toString(),
      aqi: data['current']['air_quality']['pm2_5'].toString(),
      chanceofrain: data['forecast']['forecastday'][0]['day']
              ['daily_chance_of_rain']
          .toString(),
    );
    CityListProvider cityListProvider = Provider.of<CityListProvider>(
      context,
      listen: false,
    );
    cityListProvider.changeCityatIndex(cityData, 0);
    CityDataListProvider cityDataListProvider = Provider.of<CityDataListProvider>(
      context,
      listen: false,
    );
    cityDataListProvider.changeCityatIndex(data, 0);
    CityStorage().saveCityList(
        cityListProvider.cities.map((e) => "${e.lat}:${e.lon}").toList());
    CityStorage()
        .getCityList()
        .then((value) => print("Citylist during getcurrentWeather: $value"));
  }

  @override
  void initState() {
    getCurrentLocationWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double ht = MediaQuery.of(context).size.height;
    double wt = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.maxFinite,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [themes[0], themes[1]],
              ),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Center(
                  child: Consumer<CityDataListProvider>(
                    builder: (context, cityDataListProvider, child) => Consumer<CityListProvider>(
                      builder: (context, cityProviderModel, child) => GestureDetector(
                        onVerticalDragEnd: (details) {
                          if (cityProviderModel.selectedIndex == 0 && details.primaryVelocity! > 50) {
                            setState(() {
                              showIndicator = true;
                            });
                            Future.delayed(const Duration(seconds: 1), () {
                              setState(() {
                                showIndicator = false;
                              });
                            });
                            getcurrentWeather(
                                cityProviderModel.cities[cityProviderModel.selectedIndex].lat.toString(),
                                cityProviderModel.cities[cityProviderModel.selectedIndex].lon.toString());
                          }
                        },
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  color: bgColordark2,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const ManageCityScreen()),
                                    );
                                  },
                                ),
                                Text(cityProviderModel.cities[cityProviderModel.selectedIndex].city!),
                                IconButton(
                                  icon: const Icon(Icons.account_circle_outlined),
                                  color: bgColordark2,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const AccountSettingScreen()),
                                    );
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              height: ht - 75,
                              child: Swiper(
                                itemCount: cityProviderModel.cities.length,
                                index: cityProviderModel.selectedIndex,
                                itemBuilder: (BuildContext context, int index) {
                                  return const CityWeatherCard();
                                },
                                onIndexChanged: (index) {
                                  cityProviderModel.changeIndex(index);
                                  print("swiper:${index}, selected index:${cityProviderModel.selectedIndex}");
                                },
                                scrollDirection: Axis.horizontal,
                                autoplay: false,
                                loop: false,
                                pagination: SwiperPagination(
                                  alignment: Alignment.topCenter,
                                  builder: SwiperCustomPagination(
                                    builder: (BuildContext context, SwiperPluginConfig config) {
                                      return Container(
                                        margin: const EdgeInsets.only(bottom: 20),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: List.generate(
                                            config.itemCount,
                                            (index) {
                                              return Padding(
                                                padding: const EdgeInsets.all(5),
                                                child: index == 0
                                                    ? SvgPicture.asset(
                                                        locationArrowIcon,
                                                        colorFilter: ColorFilter.mode(
                                                            cityProviderModel.selectedIndex == index
                                                                ? mainColor
                                                                : Colors.grey,
                                                            BlendMode.srcIn),
                                                        width: 10,
                                                      )
                                                    : Container(
                                                        margin: const EdgeInsets.all(3),
                                                        width: 5,
                                                        height: 5,
                                                        decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          color: cityProviderModel.selectedIndex == index
                                                              ? mainColor
                                                              : Colors.grey,
                                                        ),
                                                      ),
                                              );
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: showIndicator,
            child: Center(
              child: Container(
                height: 200,
                width: wt - 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.withOpacity(0.5),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Updating Data"),
                    SizedBox(height: 20),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}