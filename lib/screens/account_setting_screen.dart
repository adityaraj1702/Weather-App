import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/data/account.dart';
import 'package:weather_app/data/city_list.dart';
import 'package:weather_app/data/local_storage_city.dart';
import 'package:weather_app/widgets/dropdownlist_widget.dart';

class AccountSettingScreen extends StatefulWidget {
  const AccountSettingScreen({super.key});

  @override
  State<AccountSettingScreen> createState() => _AccountSettingScreenState();
}

class _AccountSettingScreenState extends State<AccountSettingScreen> {
  String _username = "";
  String _email = "";
  // String _homelocation = "";
  List<String> temperatureUnits = ["°C", "°F"];
  List<String> windSpeedUnits = ["kmph", "mph"];
  List<String> themesList = ["System", "Light", "Dark"];
  int tempUnitIndex = 0;
  int windSpeedUnitIndex = 0;
  int themeIndex = 0;

  void _loadData() {
    AccountStorage().getUserData().then((userData) {
      setState(() {
        _username = userData.username;
        _email = userData.email;
        tempUnitIndex = temperatureUnits.indexOf(userData.tempUnit);
        windSpeedUnitIndex = windSpeedUnits.indexOf(userData.windSpeedUnit);
      });
    });
  }
  void _saveData() {
    AccountStorage().saveUserData(_username,_email,temperatureUnits[tempUnitIndex],windSpeedUnits[windSpeedUnitIndex],themesList[themeIndex]);
  }

  String greetUser(String localtime) {
    final hour = int.tryParse(localtime.split(' ')[1].split(':')[0]) ??
        0; // Handle potential parsing errors

    switch (hour) {
      case int h when h >= 5 && h < 12:
        return 'Good Morning';
      case int h when h >= 12 && h < 17:
        return 'Good Afternoon';
      case int h when h >= 17 && h < 21:
        return 'Good Evening';
      default:
        return 'Hi';
    }
  }

  Future<String?> _showEditTextFieldDialog(
      BuildContext context, String labelText, String initialValue) async {
    final _textController = TextEditingController(text: initialValue);
    final result = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit $labelText'),
        content: TextField(
          controller: _textController,
          decoration: InputDecoration(hintText: 'Enter your $labelText'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final newValue = _textController.text.trim();
              if (newValue.isNotEmpty) {
                Navigator.pop(context, newValue);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
    return result;
  }

  @override
  void initState() {
    super.initState();
    _loadData(); // Load username from shared preferences on init
  }

  @override
  Widget build(BuildContext context) {
    double ht = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Account Settings",
          style: TextStyle(fontSize: 24.0), // Adjusted font size for title
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Consumer<CityListProvider>(
          builder: (context, cityListProvider, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "${greetUser(cityListProvider.cities[0].localtime!)}, ",
                        style: const TextStyle(fontSize: 27.0),
                      ),
                      Text(
                        "$_username!",
                        style: const TextStyle(fontSize: 27.0),
                      ),
                    ],
                  ),
                  IconButton(
                      onPressed: () {
                        _showEditTextFieldDialog(
                                context, "Enter your Name", _username)
                            .then((value) {
                          if (value != null) {
                            setState(() {
                              _username = value;
                              _saveData();
                            });
                          }
                        });
                      },
                      icon: const Icon(Icons.edit)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text(
                        "Email: ",
                        style:
                            TextStyle(fontSize: 30.0), // Adjusted email label size
                      ),
                      Text(_email,
                        style: const TextStyle(fontSize: 25.0),
                      ),
                    ],
                  ),
                  IconButton(
                      onPressed: () {
                        _showEditTextFieldDialog(
                                context, "Enter your Email", _email)
                            .then((value) {
                          if (value != null) {
                            setState(() {
                              _email = value;
                              _saveData();
                            });
                          }
                        });
                      },
                      icon: const Icon(Icons.edit)),
                ],
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Row(
              //       children: [
              //         const Text(
              //           "Home Location: ",
              //           style:
              //               TextStyle(fontSize: 30.0), // Adjusted email label size
              //         ),
              //         Text(_homelocation,
              //           style: const TextStyle(fontSize: 25.0),
              //         ),
              //       ],
              //     ),
              //     IconButton(
              //         onPressed: () {
              //           _showEditTextFieldDialog(
              //                   context, "Choose Home Location", _homelocation)
              //               .then((value) {
              //             if (value != null) {
              //               setState(() {
              //                 _homelocation = value;
              //               });
              //             }
              //           });
              //         },
              //         icon: const Icon(Icons.edit)),
              //   ],
              // ),
              const Row(
                children: [
                  Text(
                    "Settings ",
                    style: TextStyle(
                        fontSize: 30.0), // Adjusted settings label size
                  ),
                  Icon(Icons.settings),
                ],
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
              const Text(
                "UNITS",
                style: TextStyle(
                  fontSize: 27.0, // Adjusted UNITS label size
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Temperature unit: ",
                    style: TextStyle(fontSize: 24.0), // Adjusted label size
                  ),
                  Row(
                    children: [
                      Text(temperatureUnits[tempUnitIndex]),
                      const SizedBox(
                        width: 10,
                      ),
                      DropDownListWidget(
                        items: temperatureUnits,
                        onItemSelected: (index) {
                          setState(
                            () {
                              tempUnitIndex = index;
                              _saveData();
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Wind Speed unit: ",
                    style: TextStyle(fontSize: 24.0), // Adjusted label size
                  ),
                  Row(
                    children: [
                      Text(windSpeedUnits[windSpeedUnitIndex]),
                      const SizedBox(
                        width: 10,
                      ),
                      DropDownListWidget(
                        items: windSpeedUnits,
                        onItemSelected: (index) {
                          setState(
                            () {
                              windSpeedUnitIndex = index;
                              _saveData();
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
              const Text(
                "OTHER SETTINGS",
                style: TextStyle(
                  fontSize: 27.0,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Theme",
                    style: TextStyle(fontSize: 24.0),
                  ),
                  Row(
                    children: [
                      Text(themesList[themeIndex]),
                      const SizedBox(
                        width: 10,
                      ),
                      DropDownListWidget(
                        items: themesList,
                        onItemSelected: (index) {
                          setState(
                            () {
                              themeIndex = index;
                              _saveData();
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
