import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarController extends GetxController {
  Rx<DateTime> _selectedDay = DateTime.now().obs;
  Rx<DateTime> _focusedDay = DateTime.now().obs;
  Rx<CalendarFormat> _calendarFormat = CalendarFormat.month.obs;

  Rx<CalendarFormat> get calendarFormat => _calendarFormat;
  Rx<DateTime> get selectedDay => _selectedDay;
  Rx<DateTime> get focusedDay => _focusedDay;

  setFocusedDay(DateTime day) => _focusedDay.value;

  onDaySelected(DateTime selectedDate, DateTime focusedDate) {
    if (!isSameDay(selectedDate, _selectedDay.value)) {
      _selectedDay.value = selectedDate;
      _focusedDay.value = focusedDate;
      update();
    }
  }

  onFormatChanged(CalendarFormat format) {
    if (_calendarFormat.value != format) {
      _calendarFormat.value = format;
    }
  }
}
