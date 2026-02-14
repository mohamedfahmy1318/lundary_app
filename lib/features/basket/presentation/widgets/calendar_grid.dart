import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';

class CalendarGrid extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  const CalendarGrid({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final firstDayOfMonth = DateTime(selectedDate.year, selectedDate.month, 1);
    final daysInMonth = DateTime(
      selectedDate.year,
      selectedDate.month + 1,
      0,
    ).day;
    // Sunday = 7 in Dart's weekday, we want Sunday = 0 for grid
    final startWeekday = firstDayOfMonth.weekday % 7;

    // Previous month fill
    final prevMonthDays = DateTime(
      selectedDate.year,
      selectedDate.month,
      0,
    ).day;

    const dayHeaders = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"];

    return Column(
      children: [
        // Day Headers
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: dayHeaders.map((d) {
            return SizedBox(
              width: 36.w,
              child: Center(
                child: Text(
                  d,
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 8.h),

        // Calendar Grid (6 rows max)
        ...List.generate(6, (rowIndex) {
          return Padding(
            padding: EdgeInsets.only(bottom: 4.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(7, (colIndex) {
                final cellIndex = rowIndex * 7 + colIndex;
                final dayNumber = cellIndex - startWeekday + 1;

                // Out of range
                if (dayNumber < 1 || dayNumber > daysInMonth) {
                  int displayDay;
                  if (dayNumber < 1) {
                    displayDay = prevMonthDays + dayNumber;
                  } else {
                    displayDay = dayNumber - daysInMonth;
                  }
                  return _buildDayCell(
                    day: displayDay,
                    isCurrentMonth: false,
                    isSelected: false,
                    isToday: false,
                    onTap: null,
                  );
                }

                final cellDate = DateTime(
                  selectedDate.year,
                  selectedDate.month,
                  dayNumber,
                );
                final isSelected = dayNumber == selectedDate.day;
                final isToday =
                    cellDate.year == now.year &&
                    cellDate.month == now.month &&
                    cellDate.day == now.day;

                return _buildDayCell(
                  day: dayNumber,
                  isCurrentMonth: true,
                  isSelected: isSelected,
                  isToday: isToday,
                  onTap: () => onDateSelected(cellDate),
                );
              }),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildDayCell({
    required int day,
    required bool isCurrentMonth,
    required bool isSelected,
    required bool isToday,
    VoidCallback? onTap,
  }) {
    Color textColor;
    Color bgColor;

    if (isSelected) {
      textColor = AppColors.white;
      bgColor = AppColors.primary;
    } else if (!isCurrentMonth) {
      textColor = Colors.grey[300]!;
      bgColor = Colors.transparent;
    } else {
      textColor = AppColors.textPrimary;
      bgColor = Colors.transparent;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36.w,
        height: 36.w,
        decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
        child: Center(
          child: Text(
            "$day",
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: isSelected || isToday
                  ? FontWeight.bold
                  : FontWeight.normal,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
