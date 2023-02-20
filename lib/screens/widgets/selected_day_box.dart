import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timeline/controller/calendar_controller.dart';
import 'package:timeline/helpers/const.dart';

class SelectedDayBox extends StatelessWidget {
  SelectedDayBox({super.key});

  final calendarController = Get.put(CalendarController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Obx(
        () {
          return Text(
            DateFormat("EEEE, MMM dd, y").format(calendarController.selectedDay.value),
            style: const TextStyle(fontFamily: "FiraCode", fontSize: 16.0, color: primaryColor),
          );
        },
      ),
    );
  }
}
