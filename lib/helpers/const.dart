import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFF53214d);
Map<int, Color> swatchColor = {
  50: Color.fromRGBO(83, 33, 77, .1),
  100: Color.fromRGBO(83, 33, 77, .2),
  200: Color.fromRGBO(83, 33, 77, .3),
  300: Color.fromRGBO(83, 33, 77, .4),
  400: Color.fromRGBO(83, 33, 77, .5),
  500: Color.fromRGBO(83, 33, 77, .6),
  600: Color.fromRGBO(83, 33, 77, .7),
  700: Color.fromRGBO(83, 33, 77, .8),
  800: Color.fromRGBO(83, 33, 77, .9),
  900: Color.fromRGBO(83, 33, 77, 1),
};


const List<List<String>> weekDays = [
  ['MO', 'TU', 'WE', 'TH', 'FR', 'SA', 'SU'],
  ['MON', 'TUES', 'WEDNES', 'THURS', 'FRI', 'SATUR', 'SUN'],
];
const List<List<String>> months = [
  [
    'JAN',
    'FEB',
    'MAR',
    'APR',
    'MAY',
    'JUN',
    'JUL',
    'AUG',
    'SEP',
    'OCT',
    'NOV',
    'DEC'
  ],
  [
    'JANUARY',
    'FEBRUARY',
    'MARS',
    'APRIL',
    'MAY',
    'JUNE',
    'JULY',
    'AUGUST',
    'SEPTEMBER',
    'OCTOBER',
    'NOVEMBER',
    'DECEMBER'
  ],
];

const Map<String, Color> dayColors = {
  'day': Colors.black,
  'today': primaryColor,
  'selected': Colors.white,
  'weekend': Colors.red,
  'outside': Colors.grey,
};

DateTime midnight(date) => DateTime.parse(
    "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} 00:00:00.000Z");
