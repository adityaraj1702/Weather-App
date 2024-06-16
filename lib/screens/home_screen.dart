import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/data/city_list.dart';
import 'package:weather_app/model/weather_service.dart';
import 'package:weather_app/model/weathermodel.dart';
import 'package:weather_app/screens/manage_cities.dart';
import 'package:weather_app/utlis/colors.dart';
import 'package:weather_app/utlis/constants.dart';
import 'package:weather_app/widgets/city_weather.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Position? _currentPosition;
  WeatherModel? weatherModel;

  Future<void> _getCurrentLocation() async {
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      // Location services are not enabled
      await Geolocator.requestPermission();
      return;
    }
    LocationPermission locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied ||
        locationPermission == LocationPermission.deniedForever) {
      locationPermission = await Geolocator.requestPermission();
      // if (locationPermission == LocationPermission.deniedForever) {
      //   // Permissions are denied forever, handle appropriately.
      //   return;
      // }
    }
    // If permissions are granted or location service is already enabled
    _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> _getWeather() async {
    WeatherService weatherService = WeatherService();
    weatherModel = await weatherService.fetchWeatherData(_currentPosition!);
    print(weatherModel!.name.toString());
  }

  @override
  void initState() {
    // _getCurrentLocation();
    _getWeather();
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
                          .cities[cityProviderModel.selectedIndex]),
                      IconButton(
                        icon: const Icon(Icons.account_circle_outlined),
                        onPressed: () {},
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
