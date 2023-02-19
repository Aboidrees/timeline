import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';

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
      return [];
    }
  }
}
