import 'package:flutter/material.dart';
import 'package:quotesapp/constants.dart';
import 'package:quotesapp/widgets/MyButton.dart';
import 'package:quotesapp/widgets/MyDialog.dart';
import 'package:quotesapp/widgets/MyTextField.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NewQuotePage extends StatefulWidget {
  const NewQuotePage({super.key});

  @override
  State<NewQuotePage> createState() => _NewQuotePageState();
}

class _NewQuotePageState extends State<NewQuotePage> {
  Constants constants = Constants();
  late SharedPreferences prefs;
  TextEditingController quoteController = TextEditingController();
  TextEditingController authorController = TextEditingController();

  Future<void> postQuoteData() async {
    prefs = await SharedPreferences.getInstance();
    final ipAddress = prefs.getString('ip_address');
    final url = 'http://$ipAddress:3000/quotes';

    // Validate text fields
    if (authorController.text.isEmpty || quoteController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => MyDialog(
            title: 'Validation Error',
            content: 'Please enter both author and quote.'),
      );
      return; // Exit the function if validation fails
    }

    // Proceed with posting the quote if validation passes
    final body =
        '{"author": "${authorController.text}", "quote": "${quoteController.text}"}';

    final response = await http.post(
      Uri.parse(url),
      body: body,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      print('Quote posted successfully');
      clearControllers();
      showDialog(
          context: context,
          builder: (context) => MyDialog(
              title: 'Success!', content: 'Your quote has been posted.'));
    } else {
      print('Failed to post quote. Error: ${response.statusCode}');
      showDialog(
        context: context,
        builder: (context) => MyDialog(
            title: 'Error',
            content:
                'Quote submission failed. Status code: ${response.statusCode}'),
      );
    }
  }

  void clearControllers() {
    quoteController.clear();
    authorController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backgroundcolor,
      appBar: AppBar(
        backgroundColor: Constants.backgroundcolor,
        title: Text(
          "NewQuote",
          style: Constants.appBarTextStyle,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyTextField(
                  labelText: "Author",
                  controller: authorController,
                ),
                const SizedBox(height: 16),
                MyTextField(
                  labelText: "Quote",
                  controller: quoteController,
                ),
                const SizedBox(
                  height: 20,
                ),
                MyButton(
                  text: "Post Quote",
                  onTap: () {
                    postQuoteData();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
