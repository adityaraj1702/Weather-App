import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/data/city_list.dart';

class CityWeatherCard extends StatefulWidget {
  const CityWeatherCard({super.key});

  @override
  State<CityWeatherCard> createState() => _CityWeatherCardState();
}

class _CityWeatherCardState extends State<CityWeatherCard> {
  @override
  Widget build(BuildContext context) {
    double ht = MediaQuery.of(context).size.height;
    return Consumer<CityListProvider>(
      builder: (context, citylist, child) => Container(
        margin: const EdgeInsets.all(20),
        color: Colors.red,
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
                  citylist.cities[citylist.selectedIndex].tempC!,
                  style: const TextStyle(fontSize: 100),
                ),
                const Text(
                  "°C",
                  style: TextStyle(fontSize: 20),
                ),
              ],
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
                color: Colors.yellow,
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
                          "${citylist.cities[citylist.selectedIndex].feelslike!} °C",
                          style: const TextStyle(fontSize: 20),
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
                          style: const TextStyle(fontSize: 20),
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
                          "Chance of rain",
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          "${citylist.cities[citylist.selectedIndex].chanceofrain!}%",
                          style: const TextStyle(fontSize: 20),
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
                          "${citylist.cities[citylist.selectedIndex].windSpeedKph!} km/h",
                          style: const TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 400,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.red[100]!),
                ),
                child: const Text(
                  "5-day forecast",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
