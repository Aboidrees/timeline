import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:realm/realm.dart';
import 'package:timeline/features/events/data/event_model.dart';

class EventsController extends GetxController {
  Map<String, List<Map<String, String>>> events = {
    "2023-02-13": [
      {"title": "11", "description": "111111111111111111"},
      {"title": "22", "description": "222222222222222222"}
    ],
    "2023-02-30": [
      {"title": "33", "description": "333333333333333333"}
    ],
    "2023-02-20": [
      {"title": "44", "description": "444444444444444444"}
    ]
  };

  List<Map<String, String>> loadEvents(DateTime day) {
    if (events.containsKey(DateFormat('yyyy-MM-dd').format(day))) {
      return events[DateFormat('yyyy-MM-dd').format(day)]!;
    } else {
      return <Event>[];
    }
  }

  saveToStore(Data) {
    //     if (data != null) {
    //   if (_allPeriods.containsKey(_selectedDay)) {
    //     _allPeriods[_selectedDay]?.add(data);
    //   } else {
    //     _allPeriods[_selectedDay] = [data];
    //   }
    //   prefs.setString('periods', jsonEncode(encodePeriods(_allPeriods)));
    //   _selectedDayPeriods = _allPeriods[_selectedDay]!;
    // }
  }
}
