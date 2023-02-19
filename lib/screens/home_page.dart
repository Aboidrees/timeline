import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:timeline/helpers/size_config.dart';
import 'package:timeline/screens/widgets/add_study_period.dart';
import 'package:timeline/screens/widgets/calendar_box.dart';
import 'package:timeline/screens/widgets/time_line_box_widgte.dart';

import '../helpers/functions.dart';
import '../main.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Map<DateTime, List<dynamic>> _allPeriods;
  late List<dynamic> _selectedDayPeriods;
  late DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDayPeriods = [];
    _allPeriods = Map<DateTime, List<dynamic>>();
    _selectedDay = DateTime.now();
    _initPrefs();
  }

  void _initPrefs() async {
    setState(() {
      _allPeriods = Map<DateTime, List<dynamic>>.from(decodePeriods(json.decode(prefs.getString("periods") ?? "{}")));
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    _selectedDayPeriods.sort((a, b) => DateTime.parse(a['start']).compareTo(DateTime.parse(b['start'])));

    return Scaffold(
      appBar: AppBar(title: Text("Timeline"), centerTitle: true),
      body: SafeArea(
        child: Column(
          children: [
            CalendarWidget(periods: _allPeriods),
            TimeLineBoxWidget(selectedDayPeriods: _selectedDayPeriods),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final data = await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(bottom: 0),
                child: AddPeriod(selectedPeriods: _selectedDayPeriods, selectedDay: _selectedDay),
              ),
            ),
          );

          setState(() {
            // List _listOfDayEvents(DateTime dateTime) {
            //   if (mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)] != null) {
            //     return mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)]!;
            //   } else {
            //     return [];
            //   }
            // }
//                 setState(() {
//                   if (mySelectedEvents[
//                           DateFormat('yyyy-MM-dd').format(_selectedDate!)] !=
//                       null) {
//                     mySelectedEvents[
//                             DateFormat('yyyy-MM-dd').format(_selectedDate!)]
//                         ?.add({
//                       "eventTitle": titleController.text,
//                       "eventDescp": descpController.text,
//                     });
//                   } else {
//                     mySelectedEvents[
//                         DateFormat('yyyy-MM-dd').format(_selectedDate!)] = [
//                       {
//                         "eventTitle": titleController.text,
//                         "eventDescp": descpController.text,
//                       }
//                     ];
//                   }
//                 });
//
//                 print(
//                     "New Event for backend developer ${json.encode(mySelectedEvents)}");
//                 titleController.clear();
//                 descpController.clear();
//                 Navigator.pop(context);
//                 return;
            if (data != null) {
              if (_allPeriods.containsKey(_selectedDay)) {
                _allPeriods[_selectedDay]?.add(data);
              } else {
                _allPeriods[_selectedDay] = [data];
              }
              prefs.setString('periods', jsonEncode(encodePeriods(_allPeriods)));
              _selectedDayPeriods = _allPeriods[_selectedDay]!;
            }
          });
        },
        tooltip: 'Add a New Studding Period',
        child: Icon(Icons.add),
      ),
    );
  }
}
