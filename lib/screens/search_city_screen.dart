import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/data/city_list.dart'; // Assuming this holds city data
import 'package:weather_app/model/city_search_service.dart';

class SearchCityScreen extends StatefulWidget {
  const SearchCityScreen({super.key});

  @override
  State<SearchCityScreen> createState() => _SearchCityScreenState();
}

class _SearchCityScreenState extends State<SearchCityScreen> {
  final _searchTextController = TextEditingController();
  List<Map<String,dynamic>> _searchResults = []; // List to store search results

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }

  Future<void> _onSearch(String value) async {
    if (value.length < 4) return; // Skip search if query is too short
    // Handle API call to CitySearchService (modify based on your service)
    final results = await CitySearchService().fetchWeatherData(value);
    print("results data: $results");


    setState(() {
      _searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    double ht = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Cities"),
      ),
      body: Container(
        height: ht,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 40,
              width: double.maxFinite,
              child: TextField(
                controller: _searchTextController,
                decoration: InputDecoration(
                  hintText: 'Enter a location',
                  contentPadding: const EdgeInsets.only(top: 5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  prefixIcon: const Icon(Icons.search),
                ),
                onChanged: (value) => _onSearch(value), // Call search on change
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  final city = _searchResults[index];
                  return ListTile(
                    title: Text("${city['name']}, ${city['region']}, ${city['country']}"),
                    onTap: (){
                    print("navigating back with selected city");
                    print(city);
                      Navigator.pop(context, city);}, // Pop with city
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
