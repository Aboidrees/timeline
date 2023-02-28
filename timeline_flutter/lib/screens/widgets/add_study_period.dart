import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timeline/controller/calendar_controller.dart';
import 'package:timeline/controller/events_controller.dart';
import 'package:timeline/features/events/data/event_model.dart';
import 'package:timeline/helpers/functions.dart';
import 'package:timeline/helpers/size_config.dart';

class AddPeriod extends StatefulWidget {
  const AddPeriod({super.key});

  @override
  AddPeriodState createState() => AddPeriodState();
}

class AddPeriodState extends State<AddPeriod> {
  // Title Controller
  late TextEditingController _title;
  late TextEditingController _description;

  // Time period Controller
  late DateTime _start;
  late DateTime _end;

  @override
  void initState() {
    // Title Controller
    _title = TextEditingController();
    _description = TextEditingController();

    // Time period Controller
    _start = DateTime.now();
    _end = DateTime.now();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    double timePickerWidth = (SizeConfig.screenWidth / 2) - defaultSize * 5;

    final calendarController = Get.find<CalendarController>();
    final eventsController = Get.find<EventsController>();
    final selectedDayEvents = eventsController.events[DateFormat('yyyy-MM-dd').format(calendarController.selectedDay.value)] ?? <Event>[];

    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(defaultSize * 3)),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.80,
        padding: EdgeInsets.all(defaultSize * 3),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(defaultSize * 3)),
          boxShadow: const [BoxShadow(blurRadius: 5.0, color: Colors.black54)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: defaultSize * 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Start Time', style: Theme.of(context).textTheme.titleMedium),
                Text('End Time', style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
            SizedBox(height: defaultSize * 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: defaultSize * 15,
                  width: timePickerWidth,
                  child: CupertinoDatePicker(
                    initialDateTime: DateTime.now(),
                    mode: CupertinoDatePickerMode.time,
                    onDateTimeChanged: (time) => setState(() => _start = time),
                  ),
                ),
                SizedBox(
                  height: defaultSize * 15,
                  width: timePickerWidth,
                  child: CupertinoDatePicker(
                    initialDateTime: _end,
                    minimumDate: _start,
                    mode: CupertinoDatePickerMode.time,
                    onDateTimeChanged: (time) => setState(() => _end = time),
                  ),
                ),
              ],
            ),
            SizedBox(height: defaultSize * 2),
            TextFormField(
              controller: _title,
              validator: (value) => (value == null || value.isEmpty) ? "Please Enter title" : null,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontFamily: "Montserrat"),
              decoration: const InputDecoration(labelText: "Title", filled: true, fillColor: Colors.white),
            ),
            SizedBox(height: defaultSize * 2),
            TextFormField(
              controller: _description,
              minLines: 3,
              maxLines: 8,
              validator: (value) => (value == null || value.isEmpty) ? "Please Enter description" : null,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontFamily: "Montserrat"),
              decoration: const InputDecoration(labelText: "Description"),
            ),
            SizedBox(height: defaultSize * 2),

            // ignore: deprecated_member_use
            ElevatedButton(
              onPressed: () {
                var checkResult = checkPeriodOverlapping(selectedDayEvents, _start, _end);

                if (checkResult != null) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => ErrorMessage(
                      message: 'The selected period is overlapping'
                          ' with ${DateFormat("HH:mm").format(checkResult.start)}   '
                          ' to   ${DateFormat("HH:mm").format(checkResult.end)}     ',
                    ),
                  );
                  return;
                }

                if (DateTimeRange(start: _start, end: _end).duration.inMinutes < 1) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => const ErrorMessage(message: 'Start time is less than End time'),
                  );
                  return;
                }

                if (_title.text.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => const ErrorMessage(message: 'period title should not be empty'),
                  );
                  return;
                }

                if (_description.text.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => const ErrorMessage(message: 'period desc should not be empty'),
                  );
                  return;
                }
                // return false;

                Navigator.pop<Event>(context, Event(0, _title.text, _description.text, _start, _end));
              },
              child: const Text('Add', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
