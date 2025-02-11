import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/calendar_controller.dart';
import '../main.dart';

class CalendarSelector extends StatelessWidget {
  final Function(DateTime) onDateSelected;

  CalendarSelector({super.key, required this.onDateSelected});

  final CalendarController calendarController = Get.put(CalendarController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CalendarController>(
      builder: (c) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(7, (index) {
            final date = c.weekDates[index];
            return GestureDetector(
              onTap: () {
                c.selectDate(index);
                onDateSelected(date);
              },
              child: Column(
                spacing: 4,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: c.selectedDayIndex == index
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.secondary,
                    child: Text(
                      c.getDay(index),
                    ),
                  ),
                  Text(
                    c.getWeekday(index),
                    style: TextStyle(
                      fontSize: 12,
                      color: c.selectedDayIndex == index
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            );
          }),
        );
      },
    );
  }
}