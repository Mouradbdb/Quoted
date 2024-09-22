import 'package:flutter/material.dart';

class Constants {
  static Color backgroundcolor = const Color(0xff090C08);
  static Color quoteCardColor = const Color.fromARGB(255, 56, 50, 69);
  static List<Color> textColor = [
    Colors.white,
    const Color.fromARGB(255, 0, 255, 17),
    const Color.fromARGB(255, 255, 0, 208),
    const Color.fromARGB(255, 229, 255, 0),
  ];
  static TextStyle textstyle1 = const TextStyle(
      color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30);
  static TextStyle appBarTextStyle = TextStyle(
    fontSize: 40.0,
    fontWeight: FontWeight.bold,
    color: textColor[0],
    fontStyle: FontStyle.italic,
  );
  static TextStyle quoteStyle = TextStyle(
    fontSize: 30.0,
    fontWeight: FontWeight.bold,
    color: textColor[0], // Reference the defined variable
    fontStyle: FontStyle.italic,
    fontFamily: "Vogue",
  );
}
