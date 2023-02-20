import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:timeline/controller/calendar_controller.dart';
import 'package:timeline/controller/events_controller.dart';
import 'package:timeline/helpers/const.dart';
import 'package:timeline/helpers/size_config.dart';
import 'package:timeline/screens/widgets/day_builder.dart';

class CalendarBoxWidget extends StatefulWidget {
  const CalendarBoxWidget({super.key});

  @override
  State<CalendarBoxWidget> createState() => _CalendarBoxWidgetState();
}

class _CalendarBoxWidgetState extends State<CalendarBoxWidget> {
  Map<String, List> mySelectedEvents = {};

  @override
  Widget build(BuildContext context) {
    final calendarController = Get.find<CalendarController>();
    final eventsController = Get.find<EventsController>();
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(0),
        child: Obx(
          () => TableCalendar(
            firstDay: DateTime(2023),
            lastDay: DateTime(2024),
            focusedDay: calendarController.focusedDay.value,
            selectedDayPredicate: (day) => isSameDay(calendarController.selectedDay.value, day),
            onDaySelected: calendarController.onDaySelected,
            availableCalendarFormats: const {CalendarFormat.month: "Month"},
            onFormatChanged: calendarController.onFormatChanged,
            onPageChanged: calendarController.setFocusedDay,
            headerStyle: HeaderStyle(
              titleCentered: true,
              formatButtonVisible: false,
              titleTextStyle: TextStyle(color: primaryColor, fontSize: SizeConfig.defaultSize * 2),
            ),
            startingDayOfWeek: StartingDayOfWeek.friday,
            weekendDays: const [DateTime.friday, DateTime.saturday],
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) => DayBuilderWidget(date: day, dayType: ''),
              selectedBuilder: (context, day, focusedDay) => DayBuilderWidget(date: day, dayType: 'selected'),
              todayBuilder: (context, day, events) => DayBuilderWidget(date: day, dayType: 'today'),
              holidayBuilder: (context, day, events) => DayBuilderWidget(date: day, dayType: 'holiday'),
              outsideBuilder: (context, date, events) => DayBuilderWidget(date: date, dayType: 'outside'),
              markerBuilder: (context, day, events) {
                if (events.isNotEmpty) {
                  log(events.toString());
                  return Container(
                    width: SizeConfig.defaultSize * 1.8,
                    height: SizeConfig.defaultSize * 1.8,
                    decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(SizeConfig.defaultSize)),
                    child: Center(child: Text(events.length.toString(), style: const TextStyle(color: Colors.white))),
                  );
                }
                return null;
              },
            ),
            eventLoader: eventsController.loadDayEvents,
          ),
        ),
      ),
    );
  }
}
