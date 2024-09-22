import 'package:flutter/material.dart';
import 'package:quotesapp/constants.dart';
import 'package:quotesapp/widgets/MyButton.dart';
import 'package:quotesapp/widgets/MyTextField.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late TextEditingController ipController;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    ipController = TextEditingController();
    loadIpAddress();
  }

  @override
  void dispose() {
    ipController.dispose();
    super.dispose();
  }

  Future<void> loadIpAddress() async {
    prefs = await SharedPreferences.getInstance();
    final savedIp = prefs.getString('ip_address');
    if (savedIp != null) {
      setState(() {
        ipController.text = savedIp;
      });
    }
  }

  Future<void> saveIpAddress(String ipAddress) async {
    await prefs.setString('ip_address', ipAddress);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backgroundcolor,
      appBar: AppBar(
        backgroundColor: Constants.backgroundcolor,
        title: Text(
          'Settings',
          style: Constants.appBarTextStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyTextField(
                controller: ipController, labelText: 'Enter Server IP Address'),
            const SizedBox(height: 20.0),
            MyButton(
              text: "Save IP Address",
              onTap: () {
                saveIpAddress(ipController.text);
              },
            ),
          ],
        ),
      ),
    );
  }
}
