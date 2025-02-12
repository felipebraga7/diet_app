import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:diet_app/controller/calendar_controller.dart';

class CalendarSelector extends StatelessWidget {
  const CalendarSelector({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var colorScheme = Theme.of(context).colorScheme;
    return GetBuilder<CalendarController>(
      init: CalendarController(),
      builder: (c) {
        var curDate = c.weekDates[c.selectedDayIndex];
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  c.getSelectedDateDescriptionText(),
                  style: textTheme.titleLarge,
                ),
                IconButton(
                  icon: Icon(Icons.arrow_drop_down, size: 24), // Down arrow icon
                  color: colorScheme.inverseSurface, // Customize the color
                  onPressed: () async {
                    var pickedDate = await showDatePicker(
                      context: context,
                      initialDate: curDate,
                      firstDate: curDate.subtract(Duration(days: 3650)),
                      lastDate: curDate.add(Duration(days: 3650)),
                    );
                    if (pickedDate != null) {
                      c.initializeWeekDates(pickedDate);
                    }
                  },
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(c.weekDates.length, (index) {
                return GestureDetector(
                  onTap: () {
                    c.selectDate(index);
                  },
                  child: Column(
                    spacing: 4,
                    children: [
                      CircleAvatar(
                        radius: 15,
                        backgroundColor: c.selectedDayIndex == index ? colorScheme.primary : colorScheme.secondary,
                        child: Text(
                          style: textTheme.labelSmall?.copyWith(color: c.selectedDayIndex == index ? colorScheme.onPrimary : colorScheme.onSecondary),
                          c.getDay(index),
                        ),
                      ),
                      Text(
                        c.getWeekday(index),
                        style: textTheme.labelSmall,
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        );
      },
    );
  }
}
