import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/data/city_list.dart';

class ManageCityScreen extends StatelessWidget {
  const ManageCityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double ht = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Cities"),
      ),
      body: Container(
        height: ht,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 40,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter a location',
                  contentPadding: const EdgeInsets.only(top: 5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  prefixIcon: const Icon(Icons.search),
                ),
                onChanged: (value) {
                  // Handle user input (search logic here)
                  print('Search term: $value');
                },
              ),
            ),
            Consumer<CityListProvider>(
              builder: (context, cityListProvider, child) => Expanded(
                child: ListView.builder(
                  itemCount: cityListProvider.cities.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(cityListProvider.cities[index]),
                      subtitle: const Text("max/min temp"),
                      trailing: const Text("37°C"),
                      onTap: () {
                        // Handle city selection
                        cityListProvider.changeIndex(index);
                        Navigator.pop(context);
                        print(
                            'Selected city: ${cityListProvider.cities[index]}');
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
