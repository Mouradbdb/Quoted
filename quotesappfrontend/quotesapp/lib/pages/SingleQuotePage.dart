import 'package:flutter/material.dart';
import 'package:quotesapp/constants.dart';

class SingleQuotePage extends StatelessWidget {
  final String author;
  final String quote;

  const SingleQuotePage({
    required this.author,
    required this.quote,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backgroundcolor,
      appBar: AppBar(
        backgroundColor: Constants.backgroundcolor,
        title: Text(
          "Quote by $author",
          style: TextStyle(
            fontSize: 26.0,
            fontWeight: FontWeight.bold,
            color: Constants.textColor[0],
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    quote,
                    style: TextStyle(
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                      color: Constants.textColor[0],
                      fontStyle: FontStyle.italic,
                      fontFamily: "Vogue",
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Text(
                "- $author",
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 25.0,
                  color: Constants.textColor[0],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
