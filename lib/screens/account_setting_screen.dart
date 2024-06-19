import 'package:flutter/material.dart';
import 'package:weather_app/data/account.dart';
import 'package:weather_app/widgets/dropdownlist_widget.dart';

class AccountSettingScreen extends StatefulWidget {
  const AccountSettingScreen({super.key});

  @override
  State<AccountSettingScreen> createState() => _AccountSettingScreenState();
}

class _AccountSettingScreenState extends State<AccountSettingScreen> {
  String _username = "";
  String _email = "";
  List<String> temperatureUnits = ["°C", "°F"];
  List<String> windSppedUnits = ["kmph", "mph"];
  List<String> themesList = ["System", "Light", "Dark"];
  int tempUnitIndex = 0;
  int windSpeedUnitIndex = 0;
  int themeIndex = 0;
  void _loadData() {
    AccountStorage().getUserData().then((userData) {
      setState(() {
        _username = userData.username;
        _email = userData.email;
      });
    });
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

  int showDropdownList(BuildContext context, List<String> items) {
    int selectedItemIndex = 0; // Currently selected item index

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Item'),
        content: DropdownButton<String>(
          value: items[selectedItemIndex],
          items: items
              .map((item) => DropdownMenuItem(value: item, child: Text(item)))
              .toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              selectedItemIndex = items.indexOf(newValue);
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, selectedItemIndex),
            child: const Text('Select'),
          ),
        ],
      ),
    );

    // Wait for the dialog to close and return the selected index
    return selectedItemIndex;
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
        title: const Text("Account Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
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
            Row(
              children: [
                const Text(
                  "Hello, ",
                  style: TextStyle(fontSize: 30),
                ),
                Text(
                  "$_username!",
                  style: const TextStyle(fontSize: 40),
                ),
                IconButton(
                    onPressed: () {
                      _showEditTextFieldDialog(
                              context, "Enter your Name", _username)
                          .then((value) {
                        if (value != null) {
                          setState(() {
                            _username = value;
                          });
                        }
                      });
                    },
                    icon: const Icon(Icons.edit)),
              ],
            ),
            Row(
              children: [
                const Text(
                  "Email: ",
                  style: TextStyle(fontSize: 30),
                ),
                Text(_email),
                IconButton(
                    onPressed: () {
                      _showEditTextFieldDialog(
                              context, "Enter your Email", _email)
                          .then((value) {
                        if (value != null) {
                          setState(() {
                            _email = value;
                          });
                        }
                      });
                    },
                    icon: const Icon(Icons.edit)),
              ],
            ),
            const Row(
              children: [
                Text(
                  "Settings ",
                  style: TextStyle(fontSize: 30),
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
            const Text("UNITS"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Temperature unit: "),
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
                const Text("Wind Speed unit: "),
                Row(
                  children: [
                    Text(windSppedUnits[windSpeedUnitIndex]),
                    const SizedBox(
                      width: 10,
                    ),
                    DropDownListWidget(
                      items: windSppedUnits,
                      onItemSelected: (index) {
                        setState(
                          () {
                            windSpeedUnitIndex = index;
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            const Text("OTHER SETTINGS"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Theme"),
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
    );
  }
}
