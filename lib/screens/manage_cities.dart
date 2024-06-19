import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/data/city_list.dart';
import 'package:weather_app/data/local_storage_city.dart';
import 'package:weather_app/model/citydata_model.dart';
import 'package:weather_app/model/weather_service.dart';
import 'package:weather_app/screens/search_city_screen.dart';

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
              child: ElevatedButton.icon(
                onPressed: () async {
                  final selectedCity = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SearchCityScreen()),
                  );
                  print("navigated back with selected city");
                  print(selectedCity);
                  if (selectedCity != null) {
                    WeatherService weatherService = WeatherService();
                    var data = await weatherService.fetchWeatherData(selectedCity['lat'].toString(), selectedCity['lon'].toString());
                    CityData newCity = CityData(
                      city: selectedCity['name'].toString(),
                      lat: selectedCity['lat'].toString(),
                      lon: selectedCity['lon'].toString(),
                      tempC: data['current']['temp_c'].toString(),
                      maxtempC: data['forecast']['forecastday'][0]['day']
                              ['maxtemp_c']
                          .toString(),
                      mintempC: data['forecast']['forecastday'][0]['day']
                              ['mintemp_c']
                          .toString(),
                      avgtempC: data['forecast']['forecastday'][0]['day']
                              ['avgtemp_c']
                          .toString(),
                      tempF: data['current']['temp_f'].toString(),
                      maxtempF: data['forecast']['forecastday'][0]['day']
                              ['maxtemp_f']
                          .toString(),
                      mintempF: data['forecast']['forecastday'][0]['day']
                              ['mintemp_f']
                          .toString(),
                      avgtempF: data['forecast']['forecastday'][0]['day']
                              ['avgtemp_f']
                          .toString(),
                      feelslikeC: data['current']['feelslike_c'].toString(),
                      feelslikeF: data['current']['feelslike_f'].toString(),
                      localtime: data['location']['localtime'].toString(),
                      weatherCondition:
                          data['current']['condition']['text'].toString(),
                      windSpeedKph: data['current']['wind_kph'].toString(),
                      windSpeedMph: data['current']['wind_mph'].toString(),
                      humidity: data['current']['humidity'].toString(),
                      aqi: data['current']['air_quality']['pm2_5'].toString(),
                      chanceofrain: data['forecast']['forecastday'][0]['day']
                              ['daily_chance_of_rain']
                          .toString(),
                    );
                    Provider.of<CityListProvider>(
                      context,
                      listen: false,
                    ).addCity(newCity);
                    print("added the new city");
                    CityStorage().saveCityList(Provider.of<CityListProvider>(
                      context,
                      listen: false,
                    ).cities.map((e) => "${e.lat}:${e.lon}").toList()); // Save the city list to shared preferences
                    print("saved the city list to local storage");
                    List<String> city=await CityStorage().getCityList();
                    print(city);
                  }
                },
                icon: const Icon(Icons.search),
                label: const Text('Search Location'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                ),
              ),
            ),
            Consumer<CityListProvider>(
              builder: (context, cityListProvider, child) => Expanded(
                child: ListView.builder(
                  itemCount: cityListProvider.cities.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(cityListProvider.cities[index].city!),
                      subtitle: Text("Max:${cityListProvider.cities[index].maxtempC!}°C/Min:${cityListProvider.cities[index].mintempC!}°C"),
                      trailing: Text("${cityListProvider.cities[index].tempC!}°C"),
                      onTap: () {
                        cityListProvider.changeIndex(index);
                        Navigator.pop(context);
                        print('Selected city: ${cityListProvider.cities[index]}');
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