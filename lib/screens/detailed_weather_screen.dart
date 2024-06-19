import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/data/account.dart';
import 'package:weather_app/data/city_list.dart';
import 'package:weather_app/widgets/hourly_weather_widget.dart';

class DetailedWeatherScreen extends StatefulWidget {
  final int cityIndex;
  final List<dynamic> data;
  const DetailedWeatherScreen(
      {super.key, required this.cityIndex, required this.data});

  @override
  State<DetailedWeatherScreen> createState() => _DetailedWeatherScreenState();
}

class _DetailedWeatherScreenState extends State<DetailedWeatherScreen> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detailed Weather'),
      ),
      body: Center(
        child: Consumer<CityListProvider>(
          builder: (context, cityProviderModel, child) => Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 1.0,
                      color: Colors.grey, // Change the color as needed
                    ),
                  ),
                ],
              ),
              Text(
                widget.data[widget.cityIndex]['location']['name'],
                style: const TextStyle(fontSize: 20.0),
              ),
              Text(
                "${widget.data[widget.cityIndex]['location']['region']}, ${widget.data[widget.cityIndex]['location']['country']}",
                style: const TextStyle(fontSize: 15.0),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      tempUnit == "°C"
                          ? "${widget.data[widget.cityIndex]['current']['temp_c']}°C"
                          : "${widget.data[widget.cityIndex]['current']['temp_f']}°F",
                      style: const TextStyle(fontSize: 70.0),
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            const Text(
                              "Max : ",
                              style: TextStyle(fontSize: 20.0),
                            ),
                            Text(
                              tempUnit == "°C"
                                  ? "${widget.data[widget.cityIndex]['forecast']['forecastday'][0]['day']['maxtemp_c']}°C"
                                  : "${widget.data[widget.cityIndex]['forecast']['forecastday'][0]['day']['maxtemp_f']}°F",
                              style: const TextStyle(fontSize: 20.0),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Text(
                              "Min : ",
                              style: TextStyle(fontSize: 20.0),
                            ),
                            Text(
                              tempUnit == "°C"
                                  ? "${widget.data[widget.cityIndex]['forecast']['forecastday'][0]['day']['mintemp_c']}°C"
                                  : "${widget.data[widget.cityIndex]['forecast']['forecastday'][0]['day']['mintemp_f']}°F",
                              style: const TextStyle(fontSize: 20.0),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 1.0,
                      color: Colors.grey, // Change the color as needed
                    ),
                  ),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (int i = 0; i < 5; i++)
                      HourlyWeatherWidget(
                        tempUnit: tempUnit,
                        windSpeedUnit: windSpeedUnit,
                        cityIndex: widget.cityIndex,
                        data: widget.data,
                        hour: widget.data[widget.cityIndex]['location']
                                ['localtime']
                            .toString()
                            .substring(11, 12),
                        itemIndex: i,
                      ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 1.0,
                      color: Colors.grey, // Change the color as needed
                    ),
                  ),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Air Quality",
                    style: TextStyle(fontSize: 40),
                  ),
                  Text(" (Forcasted Data)",
                      style: TextStyle(fontSize: 20)),
                ],
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
