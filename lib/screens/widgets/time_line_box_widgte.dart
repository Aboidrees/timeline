
import 'package:flutter/material.dart';
import 'package:timeline/helpers/size_config.dart';
import 'package:timeline/screens/widgets/timeline.dart';

class TimeLineBoxWidget extends StatelessWidget {
  final List<dynamic> selectedDayPeriods;

  const TimeLineBoxWidget({Key? key, required this.selectedDayPeriods}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(SizeConfig.defaultSize * 2)),
          boxShadow: [BoxShadow(blurRadius: 2.0, color: Colors.black54)],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DayTimeline(periods: selectedDayPeriods),
        ),
      ),
    );
  }
}
