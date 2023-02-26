import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFF53214d);
Map<int, Color> swatchColor = {
  50: const Color.fromRGBO(83, 33, 77, .1),
  100: const Color.fromRGBO(83, 33, 77, .2),
  200: const Color.fromRGBO(83, 33, 77, .3),
  300: const Color.fromRGBO(83, 33, 77, .4),
  400: const Color.fromRGBO(83, 33, 77, .5),
  500: const Color.fromRGBO(83, 33, 77, .6),
  600: const Color.fromRGBO(83, 33, 77, .7),
  700: const Color.fromRGBO(83, 33, 77, .8),
  800: const Color.fromRGBO(83, 33, 77, .9),
  900: const Color.fromRGBO(83, 33, 77, 1),
};



const Map<String, Color> dayColors = {
  'day': Colors.black,
  'today': primaryColor,
  'selected': Colors.white,
  'weekend': Colors.red,
  'outside': Colors.grey,
};

DateTime midnight(date) => DateTime.parse("${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} 00:00:00.000Z");
