import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timeline/helpers/const.dart';
import 'package:timeline/helpers/functions.dart';
import 'package:timeline/helpers/size_config.dart';

class AddPeriod extends StatefulWidget {
  const AddPeriod({super.key, required this.selectedDay, required this.selectedPeriods});

  final DateTime selectedDay;
  final List<dynamic> selectedPeriods;

  @override
  _AddPeriodState createState() => _AddPeriodState();
}

class _AddPeriodState extends State<AddPeriod> {
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

    return Container(
      color: const Color(0xFF757575),
      child: Container(
        padding: EdgeInsets.all(defaultSize * 3),
        decoration: BoxDecoration(
          color: Colors.white,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.grey.shade100, Colors.white],
          ),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(defaultSize * 4), topRight: Radius.circular(defaultSize * 4)),
          boxShadow: const [BoxShadow(blurRadius: 5.0, color: Colors.black54)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: defaultSize * 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Start Time', style: TextStyle(fontSize: defaultSize * 2, color: primaryColor)),
                Text('End Time', style: TextStyle(fontSize: defaultSize * 2, color: primaryColor)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: defaultSize * 10,
                  width: timePickerWidth,
                  child: CupertinoDatePicker(
                    initialDateTime: DateTime.now(),
                    mode: CupertinoDatePickerMode.time,
                    onDateTimeChanged: (time) => setState(() => _start = time),
                  ),
                ),
                SizedBox(
                  height: defaultSize * 10,
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
            SizedBox(height: defaultSize * 2.5),
            TextFormField(
              controller: _title,
              validator: (value) => (value == null || value.isEmpty) ? "Please Enter title" : null,
              style: TextStyle(fontFamily: 'Montserrat', fontSize: defaultSize * 1.8),
              decoration: InputDecoration(
                labelText: "Title",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(defaultSize)),
              ),
            ),
            SizedBox(height: defaultSize * 2.5),
            TextFormField(
              controller: _description,
              minLines: 3,
              maxLines: 5,
              validator: (value) => (value == null || value.isEmpty) ? "Please Enter description" : null,
              style: TextStyle(fontFamily: 'Montserrat', fontSize: defaultSize * 1.8),
              decoration: InputDecoration(labelText: "Description", border: OutlineInputBorder(borderRadius: BorderRadius.circular(defaultSize))),
            ),
            SizedBox(height: defaultSize * 2),

            // ignore: deprecated_member_use
            ElevatedButton(
              onPressed: () {
                var checkResult = checkPeriodOverlapping(widget.selectedPeriods, _start, _end);

                if (checkResult != null) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => ErrorMessage(
                        'The selected period is overlapping with ${checkResult['start'].hour.toString().padLeft(2, '0')}:${checkResult['start'].minute.toString().padLeft(2, '0')}   to   ${checkResult['end'].hour.toString().padLeft(2, '0')}:${checkResult['end'].minute.toString().padLeft(2, '0')}'),
                  );
                  return;
                }

                if (DateTimeRange(start: _start, end: _end).duration.inMinutes < 1) {
                  showDialog(context: context, builder: (BuildContext context) => ErrorMessage('Start time is less than End time'));
                  return;
                }

                if (_title.text.isEmpty) {
                  showDialog(context: context, builder: (BuildContext context) => ErrorMessage('period title should not be empty'));
                  return;
                }

                if (_description.text.isEmpty) {
                  showDialog(context: context, builder: (BuildContext context) => ErrorMessage('period desc should not be empty'));
                  return;
                }
                // return false;

                Map<String, dynamic> studyPeriod = {
                  "title": _title.text,
                  "start": _start.toIso8601String(),
                  "end": _end.toIso8601String(),
                  "description": _description.text,
                };

                Navigator.pop(context, studyPeriod);
              },
              child: const Text('Add', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
