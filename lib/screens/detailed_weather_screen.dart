import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/data/account.dart';
import 'package:weather_app/data/city_list.dart';
import 'package:weather_app/utlis/colors.dart';
import 'package:weather_app/widgets/aqi_widget.dart';
import 'package:weather_app/widgets/city_weather_extra_widget.dart';
import 'package:weather_app/widgets/five_day_forecast_widget.dart';
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
  List<String> items = [
    'Today',
    'Tomorrow',
  ];
  DateTime getNthDayFromNow(int n) {
    final today = DateTime.now();
    return today.add(Duration(days: n));
  }

  String getNthDayName(int n) {
    final nthDay = getNthDayFromNow(n);
    final weekdayFormat = DateFormat('EEE');
    return weekdayFormat.format(nthDay);
  }

  @override
  void initState() {
    super.initState();
    _loadData();
    items.add(getNthDayName(2));
    items.add(getNthDayName(3));
    items.add(getNthDayName(4));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: splash_bgColortop,
      appBar: AppBar(
        title: const Text('Detailed Weather'),
        backgroundColor: splash_bgColortop,
      ),
      body: Container(
        height: double.maxFinite,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [splash_bgColortop, splash_bgColorbottom],
          ),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Consumer<CityListProvider>(
                builder: (context, cityProviderModel, child) => Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 1.0,
                            color: Colors.black,
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
                            style: const TextStyle(fontSize: 50.0),
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    "Max : ",
                                    style: TextStyle(fontSize: 15.0),
                                  ),
                                  Text(
                                    tempUnit == "°C"
                                        ? "${widget.data[widget.cityIndex]['forecast']['forecastday'][0]['day']['maxtemp_c']}°C"
                                        : "${widget.data[widget.cityIndex]['forecast']['forecastday'][0]['day']['maxtemp_f']}°F",
                                    style: const TextStyle(fontSize: 15.0),
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
                                    style: TextStyle(fontSize: 15.0),
                                  ),
                                  Text(
                                    tempUnit == "°C"
                                        ? "${widget.data[widget.cityIndex]['forecast']['forecastday'][0]['day']['mintemp_c']}°C"
                                        : "${widget.data[widget.cityIndex]['forecast']['forecastday'][0]['day']['mintemp_f']}°F",
                                    style: const TextStyle(fontSize: 15.0),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 1.0,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (int i = 0; i < 5; i++)
                            HourlyWeatherWidget(
                              tempUnit: tempUnit,
                              data: widget.data,
                              windSpeedUnit: windSpeedUnit,
                              cityIndex: widget.cityIndex,
                              hour: widget.data[widget.cityIndex]['location']['localtime'].toString().substring(11, 12),
                              itemIndex: i,
                            ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 1.0,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 52, 164, 255),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          const Row(
                            children: [
                              Text(
                                "Air Quality",
                                style: TextStyle(fontSize: 30),
                              ),
                              Text(" (Forecasted Data)", style: TextStyle(fontSize: 12)),
                            ],
                          ),
                          AqiWidget(
                            data: widget.data,
                            cityIndex: widget.cityIndex,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 1.0,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    CityWeatherExtraWidget(
                      data: widget.data,
                      cityIndex: widget.cityIndex,
                      tempUnit: tempUnit,
                      windSpeedUnit: windSpeedUnit,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 1.0,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Text(
                      "5 day Forecast",
                      style: TextStyle(fontSize: 40),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (int i = 0; i < items.length; i++)
                            FiveDayForecastWidget(
                              cityIndex: widget.cityIndex,
                              data: widget.data,
                              tempUnit: tempUnit,
                              windSpeedUnit: windSpeedUnit,
                              items: items,
                              itemIndex: i,
                            ),
                        ],
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