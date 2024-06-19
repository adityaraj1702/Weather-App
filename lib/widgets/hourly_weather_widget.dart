import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_app/utlis/constants.dart';

class HourlyWeatherWidget extends StatelessWidget {
  final int cityIndex;
  final List data;
  final String hour;
  final int itemIndex;
  final String tempUnit;
  final String windSpeedUnit;
  const HourlyWeatherWidget({
    super.key,
    required this.cityIndex,
    required this.data,
    required this.hour,
    required this.tempUnit,
    required this.windSpeedUnit,
    required this.itemIndex,
  });

  @override
  Widget build(BuildContext context) {
    bool nextday = false;
    int hr = int.parse(hour) + 2 * itemIndex;
    if (hr >= 24) {
      hr -= 24;
      nextday = true;
    }
    return Container(
      width: 130,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: itemIndex == 0
          ? Column(
              children: [
                const Text(
                  "Now",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  tempUnit == "°C"
                      ? "${data[cityIndex]['current']['temp_c']}°C"
                      : "${data[cityIndex]['current']['temp_f']}°F",
                  style: const TextStyle(fontSize: 20),
                ),
                Tooltip(
                  message: data[cityIndex]['current']['condition']['text'],
                  child: Image.network(
                    "https:${data[cityIndex]['current']['condition']['icon']}",
                    width: 64,
                    height: 64,
                    loadingBuilder:
                        (context, child, ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      locationArrowIcon,
                      colorFilter:
                          const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                      width: 15,
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Text(
                      windSpeedUnit == "kmph"
                          ? "${data[cityIndex]['current']['wind_kph']}kmph"
                          : "${data[cityIndex]['current']['wind_mph']}mph",
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ],
            )
          : !nextday
              ? Column(
                  children: [
                    Text(
                      "$hr:00",
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text(
                      tempUnit == "°C"
                          ? "${data[cityIndex]['forecast']['forecastday'][0]['hour'][hr]['temp_c']}°C"
                          : "${data[cityIndex]['forecast']['forecastday'][0]['hour'][hr]['temp_f']}°F",
                      style: const TextStyle(fontSize: 20),
                    ),
                    Tooltip(
                      message: data[cityIndex]['forecast']['forecastday'][0]
                          ['hour'][hr]['condition']['text'],
                      child: Image.network(
                        "https:${data[cityIndex]['forecast']['forecastday'][0]['hour'][hr]['condition']['icon']}",
                        width: 64,
                        height: 64,
                        loadingBuilder:
                            (context, child, ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                              child: CircularProgressIndicator());
                        },
                      ),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          locationArrowIcon,
                          colorFilter: const ColorFilter.mode(
                              Colors.black, BlendMode.srcIn),
                          width: 15,
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Text(
                          windSpeedUnit == "kmph"
                              ? "${data[cityIndex]['forecast']['forecastday'][0]['hour'][hr]['wind_kph']}kmph"
                              : "${data[cityIndex]['forecast']['forecastday'][0]['hour'][hr]['wind_mph']}mph",
                          style: const TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ],
                )
              : Column(
                  children: [
                    Text(
                      "Tomorrow $hr:00",
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text(
                      tempUnit == "°C"
                          ? "${data[cityIndex]['forecast']['forecastday'][1]['hour'][hr]['temp_c']}°C"
                          : "${data[cityIndex]['forecast']['forecastday'][1]['hour'][hr]['temp_f']}°F",
                      style: const TextStyle(fontSize: 20),
                    ),
                    Tooltip(
                      message: data[cityIndex]['forecast']['forecastday'][1]
                          ['hour'][hr]['condition']['text'],
                      child: Image.network(
                        "https:${data[cityIndex]['forecast']['forecastday'][1]['hour'][hr]['condition']['icon']}",
                        width: 64,
                        height: 64,
                        loadingBuilder:
                            (context, child, ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                              child: CircularProgressIndicator());
                        },
                      ),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          locationArrowIcon,
                          colorFilter: const ColorFilter.mode(
                              Colors.black, BlendMode.srcIn),
                          width: 15,
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Text(
                          windSpeedUnit == "kmph"
                              ? "${data[cityIndex]['forecast']['forecastday'][1]['hour'][hr]['wind_kph']}kmph"
                              : "${data[cityIndex]['forecast']['forecastday'][1]['hour'][hr]['wind_mph']}mph",
                          style: const TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ],
                ),
    );
  }
}
