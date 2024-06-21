import 'package:flutter/material.dart';

class AqiWidget extends StatelessWidget {
  final int cityIndex;
  final List<dynamic> data;
  const AqiWidget({super.key, required this.cityIndex, required this.data});

  @override
  Widget build(BuildContext context) {
    final List<String> items = ['PM2.5', 'PM10', 'O3', 'CO', 'SO2', 'NO2'];
    final List<String> itemsdata = ['pm2_5', 'pm10', 'o3', 'co', 'so2', 'no2'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
          children: List.generate(
            items.length,
            (index) => SizedBox(
              width: 70,
              child: Column(
                children: [
                  Text(
                    items[index].toString(),
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    data[cityIndex]['current']['air_quality'][itemsdata[index]].toString(),
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}