import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quotesapp/constants.dart';
import 'package:quotesapp/pages/SingleQuotePage.dart';

class QuoteCard extends StatelessWidget {
  final String author;
  final String quote;

  const QuoteCard({
    super.key,
    required this.author,
    required this.quote,
  });

  @override
  Widget build(BuildContext context) {
    Random random = Random();
    int randomNumber = random.nextInt(Constants.textColor.length);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => SingleQuotePage(
              author: author,
              quote: quote,
            ),
          ),
        );
      },
      child: SizedBox(
        width: double.infinity,
        child: Card(
          color: Colors.transparent,
          margin: const EdgeInsets.all(10.0),
          elevation: 5.0,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '"$quote"',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Constants.textColor[
                        randomNumber == 0 ? randomNumber + 3 : randomNumber],
                    fontStyle: FontStyle.italic,
                    fontFamily: "Vogue",
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  "- $author".toUpperCase(),
                  style: const TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 25.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
