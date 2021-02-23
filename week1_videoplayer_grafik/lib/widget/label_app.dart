import 'package:flutter/material.dart';

Widget namaApp(double fontSize, Color color1, Color color2,
    [String menu = ""]) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Text(
        "Week-",
        style: TextStyle(
            color: color1, fontFamily: 'Overpass', fontSize: fontSize),
      ),
      Text(
        "1",
        style: TextStyle(
            color: color1,
            fontFamily: 'Overpass',
            fontSize: fontSize,
            fontWeight: FontWeight.bold),
      ),
      Text(
        " Intermediate",
        style: TextStyle(
            color: color2, fontFamily: 'Overpass', fontSize: fontSize),
      ),
    ],
  );
}

Widget namaMenu(String menu) {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.blue,
    ),
    child: Text(
      menu,
      style: TextStyle(
          color: Colors.white,
          fontFamily: 'Overpass',
          fontSize: 16,
          fontWeight: FontWeight.bold),
    ),
  );
}
