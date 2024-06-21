import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/data/account.dart';
import 'package:weather_app/data/city_list.dart';
import 'package:weather_app/utlis/colors.dart';
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
  List<Color> themes = [splash_bgColortop,splash_bgColorbottom];
  Color textColor = Colors.black;
  int tempUnitIndex = 0;
  int windSpeedUnitIndex = 0;

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
    AccountStorage().saveUserData(_username,_email,temperatureUnits[tempUnitIndex],windSpeedUnits[windSpeedUnitIndex]);
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
        title: Text(labelText),
        content: TextField(
          controller: _textController,
          decoration: InputDecoration(hintText: labelText),
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
    double wt = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: splash_bgColortop,
      appBar: AppBar(
        title: const Text(
          "Account Settings",
          style: TextStyle(fontSize: 24.0), // Adjusted font size for title
        ),
        backgroundColor: splash_bgColortop,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [themes[0], themes[1]],
          ),
        ),
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
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: wt-20,
                    child: Text(
                      "${greetUser(cityListProvider.cities[0].localtime!)}, ",
                      style: TextStyle(
                          fontSize: 20.0,
                          color: textColor),
                          textAlign: TextAlign.start, // Adjusted font size and color
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "$_username!",
                        style: TextStyle(fontSize: 25.0,color: textColor),
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
                        icon: const Icon(Icons.edit),
                      ),
                    ],
                  ),
                  
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "Email: ",
                        style:
                            TextStyle(fontSize: 25.0,
                            color: textColor), // Adjusted email label size
                      ),
                      Text(_email,
                        style: TextStyle(fontSize: 22.0,color: textColor),
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
              const SizedBox(height: 30,),
              Row(
                children: [
                  Text(
                    "Settings ",
                    style: TextStyle(
                        fontSize: 30.0,color: textColor), // Adjusted settings label size
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
              Text(
                "UNITS",
                style: TextStyle(
                  fontSize: 27.0, color: textColor,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Temperature unit: ",
                    style: TextStyle(fontSize: 24.0,color: textColor), // Adjusted label size
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
                  Text(
                    "Wind Speed unit: ",
                    style: TextStyle(fontSize: 24.0,color: textColor), // Adjusted label size
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
              // Text(
              //   "OTHER SETTINGS",
              //   style: TextStyle(
              //     fontSize: 27.0,
              //     color: textColor,
              //   ),
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       "Theme",
              //       style: TextStyle(fontSize: 24.0, color: textColor),
              //     ),
              //     Row(
              //       children: [
              //         Text(themesList[themeIndex]),
              //         const SizedBox(
              //           width: 10,
              //         ),
              //         DropDownListWidget(
              //           items: themesList,
              //           onItemSelected: (index) {
              //             setState(
              //               () {
              //                 themeIndex = index;
              //                 _saveData();
              //               },
              //             );
              //           },
              //         ),
              //       ],
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
