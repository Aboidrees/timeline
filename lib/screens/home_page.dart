import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realm/realm.dart';
import 'package:timeline/controller/events_controller.dart';
import 'package:timeline/features/events/data/event_model.dart';
import 'package:timeline/helpers/size_config.dart';
import 'package:timeline/screens/widgets/add_study_period.dart';
import 'package:timeline/screens/widgets/calendar_box_widget.dart';
import 'package:timeline/screens/widgets/selected_day_box.dart';
import 'package:timeline/screens/widgets/time_line_box_widget.dart';
import 'package:timeline/screens/widgets/today_box.dart';

class ListBloc {
  final RealmResults<Event> events;
  final Realm _realm;
  final Map<String, List<Event>> distributedEvents = {};

  ListBloc(this.events) : _realm = events.realm;

  void addNewEvent(Event event) {
    _realm.write(
      () => _realm.add(Event(
        1 + (events.lastOrNull?.id ?? 0),
        event.title,
        event.description,
        event.start,
        event.end,
      )),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.bloc});

  final ListBloc bloc;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // _selectedDayPeriods.sort((a, b) => DateTime.parse(a['start']).compareTo(DateTime.parse(b['start'])));
    final eventsController = Get.put(EventsController());

    return Scaffold(
      appBar: AppBar(title: const Text("Timeline"), centerTitle: true),
      body: StreamBuilder<Object>(
          stream: bloc.events.changes,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

            eventsController.setEvents(bloc.events);
            return Column(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const ToDayBox(),
                        CalendarBoxWidget(events: bloc.events),
                      ],
                    ),
                    SelectedDayBox(),
                  ],
                ),
                const TimeLineBoxWidget(),
              ],
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //

          final Event? newEvent = await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => const AddPeriod(),
          );

          if (newEvent != null) {
            bloc.addNewEvent(newEvent);
          }
        },
        tooltip: 'Add a New Studding Period',
        child: const Icon(Icons.add),
      ),
    );
  }
}
