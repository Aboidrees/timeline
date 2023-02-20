import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeline/controller/calendar_controller.dart';
import 'package:timeline/controller/events_controller.dart';
import 'package:timeline/helpers/const.dart';
import 'package:timeline/screens/home_page.dart';

late SharedPreferences prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  Get.lazyPut(() => CalendarController());
  Get.lazyPut(() => EventsController(prefs));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Time Line',
      theme: ThemeData(
        primaryColor: primaryColor,
        primarySwatch: MaterialColor(0xFF53214d, swatchColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
