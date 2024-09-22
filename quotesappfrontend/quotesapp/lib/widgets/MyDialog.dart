import 'package:flutter/material.dart';
import 'package:quotesapp/constants.dart';

class MyDialog extends StatelessWidget {
  final String title;
  final String content;
  const MyDialog({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Constants.quoteCardColor,
      title: Text(
        title,
        style: const TextStyle(
            color: Color.fromARGB(255, 255, 17, 0),
            fontWeight: FontWeight.bold,
            fontSize: 20),
      ),
      content: Text(
        content,
        style: const TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontWeight: FontWeight.bold,
            fontSize: 20),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'OK',
            style: TextStyle(
                color: Color.fromARGB(255, 55, 255, 0),
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
        ),
      ],
    );
  }
}
