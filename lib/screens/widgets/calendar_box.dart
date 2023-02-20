import 'package:flutter/material.dart';
import 'package:timeline/screens/widgets/calendar_box_widget.dart';
import 'package:timeline/screens/widgets/selected_day_box.dart';
import 'package:timeline/screens/widgets/today_box.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: const [
            ToDayBox(),
            CalendarBoxWidget(),
          ],
        ),
        SelectedDayBox(),
      ],
    );
  }
}
