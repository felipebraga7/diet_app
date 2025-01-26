import 'package:diet_app/main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarSelector extends StatefulWidget {
  final DateTime initialSelectedDate;
  final Function(DateTime) onDateSelected;

  const CalendarSelector({
    super.key,
    required this.initialSelectedDate,
    required this.onDateSelected,
  });

  @override
  State<CalendarSelector> createState() => _CalendarSelectorState();
}

class _CalendarSelectorState extends State<CalendarSelector> {
  late List<DateTime> _weekDates;
  late int _selectedDayIndex;

  @override
  void initState() {
    super.initState();
    _initializeWeekDates();
    _setSelectedIndexToToday();
  }

  /// Initialize week dates with today as the last day.
  void _initializeWeekDates() {
    final today = DateTime.now().toLocal();
    _weekDates = List.generate(7, (index) => today.subtract(Duration(days: 6 - index)));
  }

  /// Set the selected day index to today (last circle by default).
  void _setSelectedIndexToToday() {
    _selectedDayIndex = 6; // Always set the last circle as today initially
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(7, (index) {
        final date = _weekDates[index];
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedDayIndex = index;
            });
            widget.onDateSelected(date);
          },
          child: Column(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: _selectedDayIndex == index
                    ? customSwatch.shade600
                    : customSwatch.shade300,
                child: Text(
                  DateFormat('d').format(date), // Day of the month
                ),
              ),
              const SizedBox(height: 5),
              Text(
                DateFormat('EEE').format(date), // Abbreviated weekday name
                style: TextStyle(
                  fontSize: 12,
                  color: _selectedDayIndex == index
                      ? customSwatch.shade600
                      : customSwatch.shade300,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}