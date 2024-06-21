import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_app/utlis/constants.dart';

class FiveDayForecastWidget extends StatelessWidget {
  final int cityIndex;
  final List<dynamic> data;
  final String tempUnit;
  final List<String> items;
  final int itemIndex;
  final String windSpeedUnit;
  const FiveDayForecastWidget({
    super.key,
    required this.cityIndex,
    required this.tempUnit,
    required this.windSpeedUnit,
    required this.items,
    required this.itemIndex, required this.data,
  });

  @override
  Widget build(BuildContext context) {
    DateTime getNthDayFromNow(int n) {
      final today = DateTime.now();
      return today.add(Duration(days: n));
    }

    return Container(
      width: 130,
      height: 300,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 52, 164, 255),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
          child: Column(
            children: [
              Text(
                items[itemIndex],
                style: const TextStyle(fontSize: 20),
              ),
              Text(
                "${getNthDayFromNow(itemIndex).day}/${getNthDayFromNow(itemIndex).month}",
                style: const TextStyle(fontSize: 15),
              ),
              Tooltip(
                message:
                    "${data[cityIndex]['forecast']['forecastday'][0]['hour'][11 + itemIndex]['condition']['text']}",
                child: Image.network(
                  "https:${data[cityIndex]['forecast']['forecastday'][0]['hour'][11 + itemIndex]['condition']['icon']}",
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
                tempUnit == "°C"
                    ? "${data[cityIndex]['forecast']['forecastday'][0]['day']['maxtemp_c']}°C"
                    : "${data[cityIndex]['forecast']['forecastday'][0]['day']['maxtemp_f']}°F",
                style: const TextStyle(fontSize: 15),
              ),
              const Spacer(),
              Text(
                tempUnit == "°C"
                    ? "${data[cityIndex]['forecast']['forecastday'][0]['day']['mintemp_c']}°C"
                    : "${data[cityIndex]['forecast']['forecastday'][0]['day']['mintemp_f']}°F",
                style: const TextStyle(fontSize: 15),
              ),
              Tooltip(
                message:
                    "${data[cityIndex]['forecast']['forecastday'][0]['hour'][itemIndex]['condition']['text']}",
                child: Image.network(
                  "https:${data[cityIndex]['forecast']['forecastday'][0]['hour'][itemIndex]['condition']['icon']}",
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
                mainAxisAlignment: MainAxisAlignment.center,
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
                  itemIndex != 0
                      ? Text(
                          windSpeedUnit == "kmph"
                              ? "${data[cityIndex]['forecast']['forecastday'][0]['day']['maxwind_kph']}kmph"
                              : "${data[cityIndex]['forecast']['forecastday'][0]['day']['maxwind_mph']}mph",
                          style: const TextStyle(fontSize: 15),
                        )
                      : Text(
                          windSpeedUnit == "kmph"
                              ? "${data[cityIndex]['current']['wind_kph']}kmph"
                              : "${data[cityIndex]['current']['wind_mph']}mph",
                          style: const TextStyle(fontSize: 15),
                        ),
                ],
              ),
            ],
          ),
        ),
    );
  }
}
