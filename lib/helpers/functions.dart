import 'package:flutter/material.dart';
import 'package:timeline/features/events/data/event_model.dart';
import 'package:timeline/helpers/const.dart';
import 'package:timeline/helpers/size_config.dart';

Map<String, List<dynamic>> encodePeriods(Map<DateTime, List<dynamic>> periods) {
  Map<String, List<dynamic>> newPeriod = {};

  periods.forEach((key, value) => newPeriod[key.toString()] = periods[key]!);
  return newPeriod;
}

Map<DateTime, List<dynamic>> decodePeriods(Map<String, dynamic> periods) {
  Map<DateTime, List<dynamic>> newPeriod = {};
  periods.forEach((key, value) => newPeriod[DateTime.parse(key)] = periods[key]);
  return newPeriod;
}

Event? checkPeriodOverlapping(List<Event> events, DateTime startTime, DateTime endTime) {
  for (int i = 0; i < events.length; i++) {
    final event = events[i];

    if ((startTime.isAfter(event.start) && startTime.isBefore(event.end)) ||
        (endTime.isAfter(event.start) && endTime.isBefore(event.end))) {
      return event;
    }
  }
  return null;
}

class ErrorMessage extends StatelessWidget {
  final String message;

  const ErrorMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      //title: Text('Alert'),

      content: SizedBox(
        height: SizeConfig.screenHeight / 12,
        child: Center(child: Text(message, textAlign: TextAlign.center)),
      ),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        TextButton(
          child: const Icon(Icons.close, color: primaryColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
