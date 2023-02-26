import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timeline/controller/calendar_controller.dart';
import 'package:timeline/controller/events_controller.dart';
import 'package:timeline/helpers/const.dart';
import 'package:timeline/helpers/size_config.dart';
import 'package:timelines/timelines.dart';

class DayTimeline extends StatelessWidget {
  const DayTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    final calendarController = Get.put(CalendarController());
    final eventsController = Get.find<EventsController>();

    final selectedDay = DateFormat("yyyy-MM-dd").format(calendarController.selectedDay.value);

    final dayEvents = eventsController.events[selectedDay] ?? [];

    SizeConfig().init(context);
    final double defaultSize = SizeConfig.defaultSize;

    return SingleChildScrollView(
      child: FixedTimeline.tileBuilder(
        theme: TimelineThemeData(
          color: primaryColor,
          nodePosition: 0.2,
          indicatorPosition: 1,
        ),
        builder: TimelineTileBuilder.connectedFromStyle(
          oppositeContentsBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  DateFormat("hh:mm").format(dayEvents[index].start),
                  style: TextStyle(fontFamily: 'FiraCode', fontWeight: FontWeight.bold, fontSize: defaultSize * 1.6),
                ),
                const Icon(Icons.keyboard_arrow_down_rounded),
                Text(
                  DateFormat("hh:mm").format(dayEvents[index].end),
                  style: TextStyle(fontFamily: 'FiraCode', fontWeight: FontWeight.bold, fontSize: defaultSize * 1.6),
                ),
              ],
            ),
          ),
          contentsBuilder: (context, index) => Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(dayEvents[index].title, style: Theme.of(context).textTheme.titleMedium),
                  SizedBox(height: defaultSize),
                  Text(dayEvents[index].description),
                ],
              ),
            ),
          ),
          connectorStyleBuilder: (_, index) => calcConnectorStyle(index, dayEvents.length),
          indicatorStyleBuilder: (context, index) => calcIndicatorStyle(index, dayEvents.length),
          itemCount: dayEvents.length,
        ),
      ),
    );
  }

  ConnectorStyle calcConnectorStyle(int index, eventsCount) {
    return (index >= eventsCount - 1)
        ? ConnectorStyle.transparent
        : (index % 2 == 1)
            ? ConnectorStyle.dashedLine
            : ConnectorStyle.solidLine;
  }

  IndicatorStyle calcIndicatorStyle(int index, eventsCount) {
    return (index % 2 == 1) ? IndicatorStyle.outlined : IndicatorStyle.dot;
  }
}
