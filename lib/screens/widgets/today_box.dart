import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timeline/controller/calendar_controller.dart';
import 'package:timeline/helpers/const.dart';
import 'package:timeline/helpers/size_config.dart';

class ToDayBox extends StatelessWidget {
  const ToDayBox({super.key});

  @override
  Widget build(BuildContext context) {
    final DateTime today = DateTime.now();

    final controller = Get.find<CalendarController>();

    return GestureDetector(
      onTap: () => controller.onDaySelected(today, today),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              DateFormat(DateFormat.WEEKDAY).format(today),
              style: TextStyle(fontFamily: 'FiraCode', fontSize: SizeConfig.defaultSize * 1.8, color: primaryColor),
            ),
            Text(
              DateFormat(DateFormat.DAY).format(today),
              style: TextStyle(fontFamily: 'FiraCode', fontSize: SizeConfig.defaultSize * 7.0, color: primaryColor),
            ),
            Text(
              DateFormat('${DateFormat.ABBR_MONTH}, ${DateFormat.YEAR}').format(today),
              style: TextStyle(fontFamily: 'FiraCode', fontSize: SizeConfig.defaultSize * 1.5, color: primaryColor),
            )
          ],
        ),
      ),
    );
  }
}
