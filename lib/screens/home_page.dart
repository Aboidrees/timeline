import 'package:flutter/material.dart';
import 'package:timeline/helpers/size_config.dart';
import 'package:timeline/screens/widgets/add_study_period.dart';
import 'package:timeline/screens/widgets/calendar_box.dart';
import 'package:timeline/screens/widgets/time_line_box_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<dynamic> _selectedDayPeriods;
  late DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDayPeriods = [];
    _selectedDay = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    _selectedDayPeriods.sort((a, b) => DateTime.parse(a['start']).compareTo(DateTime.parse(b['start'])));

    return Scaffold(
      appBar: AppBar(title: const Text("Timeline"), centerTitle: true),
      body: SafeArea(
        child: Column(
          children: const [
            CalendarWidget(),
            TimeLineBoxWidget(),
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
                padding: const EdgeInsets.only(bottom: 0),
                child: AddPeriod(
                  selectedPeriods: _selectedDayPeriods,
                  selectedDay: _selectedDay,
                ),
              ),
            ),
          );

          // setState(() {
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
//                       "description": descriptionController.text,
//                     });
//                   } else {
//                     mySelectedEvents[
//                         DateFormat('yyyy-MM-dd').format(_selectedDate!)] = [
//                       {
//                         "eventTitle": titleController.text,
//                         "description": descriptionController.text,
//                       }
//                     ];
//                   }
//                 });
//
//                 print(
//                     "New Event for backend developer ${json.encode(mySelectedEvents)}");
//                 titleController.clear();
//                 descriptionController.clear();
//                 Navigator.pop(context);
//                 return;

          // });
        },
        tooltip: 'Add a New Studding Period',
        child: const Icon(Icons.add),
      ),
    );
  }
}
