import 'package:diet_app/controller/meal_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CalendarController extends GetxController {
  List<DateTime> weekDates = [];
  late int selectedDayIndex;

  @override
  void onInit() {
    super.onInit();
    var now = DateTime.now();
    initializeWeekDates(DateTime(now.year, now.month, now.day));
  }

  void initializeWeekDates(DateTime date) {
    weekDates.clear();
    DateTime startDate = date.subtract(Duration(days: date.weekday % 7));
    for (DateTime date = startDate; date.isBefore(startDate.add(Duration(days: 7))); date = date.add(Duration(days: 1))) {
      weekDates.add(date);
    }
    selectedDayIndex = weekDates.indexOf(date);
  }

  void selectDate(int index) {
    selectedDayIndex = index;
    Get.put(MealController()).updateSelectedDate(weekDates[index]);
    update();
  }

  String getDay(int index) {
    return DateFormat('d').format(weekDates[index]);
  }

  String getWeekday(int index) {
    return DateFormat('EEE').format(weekDates[index]);
  }


  String getSelectedDateDescriptionText() {
    var selectedDate = weekDates[selectedDayIndex];
    DateTime now = DateTime.now();
    DateTime currentDate = DateTime(now.year, now.month, now.day);
    int differenceInDays = selectedDate.difference(currentDate).inDays;

    if (differenceInDays == 0) {
      return "Hoje";
    } else if (differenceInDays == 1) {
      return "Amanhã";
    } else if (differenceInDays == -1) {
      return "Ontem";
    }

    DateTime startOfWeek = currentDate.subtract(Duration(days: currentDate.weekday));
    DateTime endOfWeek = startOfWeek.add(Duration(days: 7));

    if (selectedDate.isAfter(startOfWeek.subtract(Duration(days: 1))) &&
        selectedDate.isBefore(endOfWeek.add(Duration(days: 1)))) {
      return DateFormat('EEEE').format(selectedDate);
    }
    return DateFormat('d/MMM').format(selectedDate);
  }
}