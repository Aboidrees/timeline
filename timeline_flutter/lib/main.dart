import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realm/realm.dart';
import 'package:timeline/features/events/data/event_model.dart';
import 'package:timeline/helpers/const.dart';
import 'package:timeline/screens/home_page.dart';

void main() async {
  final realm = Realm(Configuration.local([Event.schema]));
  final allItems = realm.all<Event>();

  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp(events: allItems));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.events});
  final RealmResults<Event> events;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Time Line',
      theme: ThemeData(
        primaryColor: primaryColor,
        primarySwatch: MaterialColor(0xFF53214d, swatchColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          titleLarge: const TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
          titleMedium: const TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
          titleSmall: const TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(color: Colors.grey.shade700, fontWeight: FontWeight.normal),
          bodyMedium: TextStyle(color: Colors.grey.shade700, fontWeight: FontWeight.normal),
          bodySmall: TextStyle(color: Colors.grey.shade700, fontWeight: FontWeight.normal),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(bloc: ListBloc(events)),
    );
  }
}
