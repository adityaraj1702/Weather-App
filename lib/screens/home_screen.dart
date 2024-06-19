import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/data/city_list.dart';
import 'package:weather_app/model/citydata_model.dart';
import 'package:weather_app/model/weather_service.dart';
import 'package:weather_app/model/weathermodel.dart';
import 'package:weather_app/screens/account_setting_screen.dart';
import 'package:weather_app/screens/manage_cities.dart';
import 'package:weather_app/utlis/colors.dart';
import 'package:weather_app/utlis/constants.dart';
import 'package:weather_app/utlis/utlis_functions.dart';
import 'package:weather_app/widgets/city_weather.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MyFucntions func = MyFucntions();
  Position? currentPosition;

  void getcurrentWeather() async {
    WeatherService weatherService = WeatherService();
    Position currPos = await func.getCurrentLocation();
    print("current position: $currPos");
    var data = await weatherService.fetchWeatherData(currPos.latitude.toString(), currPos.longitude.toString());
    print(data);
    CityListProvider cityListProvider = Provider.of<CityListProvider>(
      context,
      listen: false,
    );
    CityData cityData = CityData(
      city: data['location']['name'].toString(),
      tempC: data['current']['temp_c'].toString(),
      maxtempC: data['forecast']['forecastday'][0]['day']['maxtemp_c'].toString(),
      mintempC: data['forecast']['forecastday'][0]['day']['mintemp_c'].toString(),
      avgtempC: data['forecast']['forecastday'][0]['day']['avgtemp_c'].toString(),
      tempF: data['current']['temp_f'].toString(),
      maxtempF: data['forecast']['forecastday'][0]['day']['maxtemp_f'].toString(),
      mintempF: data['forecast']['forecastday'][0]['day']['mintemp_f'].toString(),
      avgtempF: data['forecast']['forecastday'][0]['day']['avgtemp_f'].toString(),
      feelslike: data['current']['feelslike_c'].toString(),
      localtime: data['location']['localtime'].toString(),
      weatherCondition: data['current']['condition']['text'].toString(),
      windSpeedKph: data['current']['wind_kph'].toString(),
      windSpeedMph: data['current']['wind_mph'].toString(),
      humidity: data['current']['humidity'].toString(),
      aqi: data['current']['air_quality']['pm2_5'].toString(),
      chanceofrain: data['forecast']['forecastday'][0]['day']
              ['daily_chance_of_rain'].toString(),
    );

    cityListProvider.changeCityatIndex(cityData, 0);
  }

  @override
  void initState() {
    getcurrentWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double ht = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Consumer<CityListProvider>(
              builder: (context, cityProviderModel, child) => Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ManageCityScreen()),
                          );
                        },
                      ),
                      Text(cityProviderModel
                          .cities[cityProviderModel.selectedIndex].city!),
                      IconButton(
                        icon: const Icon(Icons.account_circle_outlined),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AccountSettingScreen()),
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
                        print(
                            "swiper:${index}, selected index:${cityProviderModel.selectedIndex}");
                      },
                      scrollDirection: Axis.horizontal,
                      autoplay: false,
                      loop: false,
                      pagination: SwiperPagination(
                        alignment: Alignment.topCenter,
                        builder: SwiperCustomPagination(
                          builder: (BuildContext context,
                              SwiperPluginConfig config) {
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
                                                  cityProviderModel
                                                              .selectedIndex ==
                                                          index
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
                                                color: cityProviderModel
                                                            .selectedIndex ==
                                                        index
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
    );
  }
}
