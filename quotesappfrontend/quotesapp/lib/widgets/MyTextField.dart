import 'package:flutter/material.dart';
import 'package:quotesapp/constants.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  const MyTextField(
      {super.key, required this.controller, required this.labelText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: Constants.quoteStyle,
      minLines: null,
      maxLines: null,
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
        labelStyle: Constants.quoteStyle,
      ),
    );
  }
}
