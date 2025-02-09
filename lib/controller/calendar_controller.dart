import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CalendarController extends GetxController {
  List<DateTime> weekDates = [];
  int selectedDayIndex = 6;

  @override
  void onInit() {
    super.onInit();
    _initializeWeekDates();
  }

  void _initializeWeekDates() {
    final today = DateTime.now().toLocal();
    weekDates = List.generate(7, (index) => today.subtract(Duration(days: 6 - index)));
  }

  void selectDate(int index) {
    selectedDayIndex = index;
    update();
  }

  String getDay(int index) {
    return DateFormat('d').format(weekDates[index]);
  }

  String getWeekday(int index) {
    return DateFormat('EEE').format(weekDates[index]);
  }
}