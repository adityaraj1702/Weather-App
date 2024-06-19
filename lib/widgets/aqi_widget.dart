import 'package:flutter/material.dart';

class AqiWidget extends StatelessWidget {
  final List data;
  const AqiWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final List<String> items = ['PM2.5', 'PM10', 'O3', 'CO', 'SO2', 'NO2'];
    return Row(
      children: List.generate(
        items.length,
        (index) => Column(
          children: [
            Text(items[index]),
            Text('Text Value ${index + 1}'),// add data here.
          ],
        ),
      ),
    );
  }
}
