import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:realm/realm.dart';
import 'package:timeline/features/events/data/event_model.dart';

class EventsController extends GetxController {
  final RxMap<String, List<Event>> _events = <String, List<Event>>{}.obs;

  RxMap<String, List<Event>> get events => _events;

  void setEvents(RealmResults<Event> data) {
    _events.clear();
    for (Event event in data) {
      final dayKey = DateFormat('yyyy-MM-dd').format(event.start);
      if (_events[dayKey]?.isNotEmpty ?? false) {
        _events[dayKey]!.add(event);
      } else {
        _events[dayKey] = [event];
      }
    }
  }

  List<Event> loadEvents(DateTime day) {
    if (_events.containsKey(DateFormat('yyyy-MM-dd').format(day))) {
      return _events[DateFormat('yyyy-MM-dd').format(day)] ?? [];
    } else {
      return <Event>[];
    }
  }
}
