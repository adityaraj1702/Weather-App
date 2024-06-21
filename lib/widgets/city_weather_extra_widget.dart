import 'package:flutter/material.dart';

class CityWeatherExtraWidget extends StatelessWidget {
  final int cityIndex;
  final List<dynamic> data;
  final String tempUnit;
  final String windSpeedUnit;
  const CityWeatherExtraWidget(
      {super.key,
      required this.cityIndex,
      required this.tempUnit,
      required this.windSpeedUnit,
      required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      padding: const EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 52, 164, 255),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      const Text(
                        "Sunrise ",
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        data[cityIndex]['forecast']['forecastday'][0]['astro']
                                ['sunrise']
                            .toString(),
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  const Text(
                    "Real feel",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    tempUnit == "°C"
                        ? "${data[cityIndex]['current']['feelslike_c']}°C"
                        : "${data[cityIndex]['current']['feelslike_f']}°F",
                    style: const TextStyle(fontSize: 15),
                  ),
                  const Text(
                    "Chance of rain",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "${data[cityIndex]['forecast']['forecastday'][0]['day']['daily_chance_of_rain']}%",
                    style: const TextStyle(fontSize: 18),
                  ),
                  const Text(
                    "Wind speed",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    windSpeedUnit == "kmph"
                        ? "${data[cityIndex]['current']['wind_kph']} kmph"
                        : "${data[cityIndex]['current']['wind_mph']} mph",
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      const Text(
                        "Sunset ",
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        data[cityIndex]['forecast']['forecastday'][0]['astro']
                                ['sunset']
                            .toString(),
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  const Text(
                    "Humidity",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "${data[cityIndex]['current']['humidity']}%",
                    style: const TextStyle(fontSize: 18),
                  ),
                  const Text(
                    "Pressure",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "${data[cityIndex]['current']['pressure_mb']} mbar",
                    style: const TextStyle(fontSize: 18),
                  ),
                  const Text(
                    "UV index",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    data[cityIndex]['current']['uv'].toString(),
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
