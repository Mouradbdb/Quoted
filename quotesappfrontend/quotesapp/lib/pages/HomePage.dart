import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quotesapp/constants.dart';
import 'package:quotesapp/pages/NewQuotePage.dart';
import 'package:quotesapp/pages/SettingsPage.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:quotesapp/widgets/QuoteCard.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Map<String, dynamic>>> quotedata;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    checkIpAddress();
  }

  Future<void> checkIpAddress() async {
    prefs = await SharedPreferences.getInstance();
    final savedIp = prefs.getString('ip_address');
    if (savedIp != null) {
      setState(() {
        quotedata = getData(savedIp);
      });
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SettingsPage()),
      );
    }
  }

  // Fetches the data from the API
  Future<List<Map<String, dynamic>>> getData(String ipAddress) async {
    final response =
        await http.get(Uri.parse('http://$ipAddress:3000/quotes/'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Failed to load quotes');
    }
  }

  Future<void> goToSettingsPage() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingsPage()),
    );
    // When settings page pops, check if IP address is saved again
    checkIpAddress();
  }

  void goToAddNewQuotePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NewQuotePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backgroundcolor,
      appBar: AppBar(
        title: Text("Quoted", style: Constants.appBarTextStyle),
        backgroundColor: Constants.backgroundcolor,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: goToAddNewQuotePage,
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: goToSettingsPage,
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: quotedata,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text(
                'Error: ${snapshot.error}',
                style: Constants.textstyle1,
              );
            } else if (snapshot.hasData) {
              final quotes = snapshot.data!;
              return ListView.builder(
                itemCount: quotes.length,
                itemBuilder: (context, index) {
                  final quote = quotes[index];
                  return QuoteCard(
                    author: quote['author'],
                    quote: quote['quote'],
                  );
                },
              );
            } else {
              return Text(
                'No data available',
                style: Constants.textstyle1,
              );
            }
          },
        ),
      ),
    );
  }
}
