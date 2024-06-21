import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/data/account.dart';
import 'package:weather_app/data/city_data_list_provider.dart';
import 'package:weather_app/data/city_list.dart';
import 'package:weather_app/screens/detailed_weather_screen.dart';
import 'package:weather_app/utlis/colors.dart';

class CityWeatherCard extends StatefulWidget {
  const CityWeatherCard({super.key,});

  @override
  State<CityWeatherCard> createState() => _CityWeatherCardState();
}

class _CityWeatherCardState extends State<CityWeatherCard> {
  String tempUnit = "";
  String windSpeedUnit = "";
  void _loadData() {
    AccountStorage().getUserData().then((userData) {
      setState(() {
        tempUnit = userData.tempUnit;
        windSpeedUnit = userData.windSpeedUnit;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    double ht = MediaQuery.of(context).size.height;
    double wt = MediaQuery.of(context).size.width;
    return Consumer<CityDataListProvider>(
        builder: (context, cityDatalistProvider, child) => Consumer<CityListProvider>(
        builder: (context, citylist, child) => Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    tempUnit == "°C"
                        ? citylist.cities[citylist.selectedIndex].tempC!
                        : citylist.cities[citylist.selectedIndex].tempF!,
                    style: const TextStyle(fontSize: 100),
                  ),
                  Text(
                    tempUnit,
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              Tooltip(
                message: citylist.cities[citylist.selectedIndex].weatherCondition!,
                child: Image.network(
                  "https:${cityDatalistProvider.cityDataList[citylist.selectedIndex]['current']['condition']['icon']}",
                  width: 64,
                  height: 64,
                  loadingBuilder:
                      (context, child, ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
              Text(
                citylist.cities[citylist.selectedIndex].weatherCondition!,
                style: const TextStyle(fontSize: 20),
              ),
              Text(
                "AQI ${citylist.cities[citylist.selectedIndex].aqi!}",
                style: const TextStyle(fontSize: 20),
              ),
              Container(
                height: ht * 0.28,
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [splash_bgColortop, splash_bgColorbottom],
                  ),
                ),
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            "Feels like",
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            tempUnit == "°C"
                                ? "${citylist.cities[citylist.selectedIndex].feelslikeC!} °C"
                                : "${citylist.cities[citylist.selectedIndex].feelslikeF!} °F",
                            style: const TextStyle(fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            "Humidity",
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            "${citylist.cities[citylist.selectedIndex].humidity!} %",
                            style: const TextStyle(fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RichText(
                            text: const TextSpan(
                              text:"Chance of rain",
                              style: TextStyle(fontSize: 20,color: Colors.black),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "${citylist.cities[citylist.selectedIndex].chanceofrain!}%",
                            style: const TextStyle(fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            "Wind speed",
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            windSpeedUnit == "kmph"
                                ? "${citylist.cities[citylist.selectedIndex].windSpeedKph!} kmph"
                                : "${citylist.cities[citylist.selectedIndex].windSpeedMph!} mph",
                            style: const TextStyle(fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: wt - 80,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 0, 150, 219),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailedWeatherScreen(
                          cityIndex: citylist.selectedIndex,
                          data: cityDatalistProvider.cityDataList,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent, // Transparent background
                    disabledForegroundColor: Colors.transparent.withOpacity(0.38),
                    disabledBackgroundColor: Colors.transparent.withOpacity(
                        0.12), // Optional for some themes (removes color overlay)
                    shadowColor: Colors.transparent, // Transparent shadow
                  ),
                  child: const Center(
                    child: Text(
                      "Detailed Forecast",
                      style: TextStyle(fontSize: 20,
                      color: Colors.black),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
