// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:table_calendar/table_calendar.dart';
//
// void main() {
//   runApp(
//     MaterialApp(
//       home: EventCalendarScreen(),
//     ),
//   );
// }
//
// class EventCalendarScreen extends StatefulWidget {
//   const EventCalendarScreen({Key? key}) : super(key: key);
//
//   @override
//   State<EventCalendarScreen> createState() => _EventCalendarScreenState();
// }
//
// class _EventCalendarScreenState extends State<EventCalendarScreen> {
//   CalendarFormat _calendarFormat = CalendarFormat.month;
//   DateTime _focusedDay = DateTime.now();
//   DateTime? _selectedDate;
//
//   Map<String, List> mySelectedEvents = {};
//
//   final titleController = TextEditingController();
//   final descpController = TextEditingController();
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _selectedDate = _focusedDay;
//
//     loadPreviousEvents();
//   }
//
//   loadPreviousEvents() {
//     mySelectedEvents = {
//       "2022-09-13": [
//         {"eventDescp": "11", "eventTitle": "111"},
//         {"eventDescp": "22", "eventTitle": "22"}
//       ],
//       "2022-09-30": [
//         {"eventDescp": "22", "eventTitle": "22"}
//       ],
//       "2022-09-20": [
//         {"eventTitle": "ss", "eventDescp": "ss"}
//       ]
//     };
//   }
//
//   List _listOfDayEvents(DateTime dateTime) {
//     if (mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)] != null) {
//       return mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)]!;
//     } else {
//       return [];
//     }
//   }
//
//   _showAddEventDialog() async {
//     await showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text(
//           'Add New Event',
//           textAlign: TextAlign.center,
//         ),
//         content: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               controller: titleController,
//               textCapitalization: TextCapitalization.words,
//               decoration: const InputDecoration(
//                 labelText: 'Title',
//               ),
//             ),
//             TextField(
//               controller: descpController,
//               textCapitalization: TextCapitalization.words,
//               decoration: const InputDecoration(labelText: 'Description'),
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             child: const Text('Add Event'),
//             onPressed: () {
//               if (titleController.text.isEmpty &&
//                   descpController.text.isEmpty) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(
//                     content: Text('Required title and description'),
//                     duration: Duration(seconds: 2),
//                   ),
//                 );
//                 //Navigator.pop(context);
//                 return;
//               } else {
//                 print(titleController.text);
//                 print(descpController.text);
//
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
//               }
//             },
//           )
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text('Event Calendar Example'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             TableCalendar(
//               firstDay: DateTime(2022),
//               lastDay: DateTime(2024),
//               focusedDay: _focusedDay,
//               calendarFormat: _calendarFormat,
//               onDaySelected: (selectedDay, focusedDay) {
//                 if (!isSameDay(_selectedDate, selectedDay)) {
//                   // Call `setState()` when updating the selected day
//                   setState(() {
//                     _selectedDate = selectedDay;
//                     _focusedDay = focusedDay;
//                   });
//                 }
//               },
//               selectedDayPredicate: (day) {
//                 return isSameDay(_selectedDate, day);
//               },
//               onFormatChanged: (format) {
//                 if (_calendarFormat != format) {
//                   // Call `setState()` when updating calendar format
//                   setState(() {
//                     _calendarFormat = format;
//                   });
//                 }
//               },
//               onPageChanged: (focusedDay) {
//                 // No need to call `setState()` here
//                 _focusedDay = focusedDay;
//               },
//               eventLoader: _listOfDayEvents,
//             ),
//             ..._listOfDayEvents(_selectedDate!).map(
//               (myEvents) => ListTile(
//                 leading: const Icon(Icons.done, color: Colors.teal),
//                 title: Padding(
//                   padding: const EdgeInsets.only(bottom: 8.0),
//                   child: Text('Event Title:   ${myEvents['eventTitle']}'),
//                 ),
//                 subtitle: Text('Description:   ${myEvents['eventDescp']}'),
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () => _showAddEventDialog(),
//         label: const Text('Add Event'),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeline/helpers/const.dart';
import 'package:timeline/screens/home_page.dart';

late SharedPreferences prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
      home: HomePage(),
    );
  }
}
