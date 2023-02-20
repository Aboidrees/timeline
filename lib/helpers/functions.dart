import 'package:flutter/material.dart';
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

dynamic checkPeriodOverlapping(List selectedPeriods, DateTime startTime, DateTime endTime) {
  for (int i = 0; i < selectedPeriods.length; i++) {
    DateTime startTime0 = DateTime.parse(selectedPeriods[i]['start']);
    DateTime endTime0 = DateTime.parse(selectedPeriods[i]['end']);
    if ((startTime.isAfter(startTime0) && startTime.isBefore(endTime0)) || (endTime.isAfter(startTime0) && endTime.isBefore(endTime0))) {
      return {'start': startTime0, 'end': endTime0};
    }
  }
  return null;
}

class ErrorMessage extends StatelessWidget {
  final String message;

  const ErrorMessage(this.message, {super.key});

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
        TextButton(child: const Icon(Icons.close, color: primaryColor), onPressed: () => Navigator.of(context).pop()),
      ],
    );
  }
}
