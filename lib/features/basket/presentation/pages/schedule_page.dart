import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_bar_factory.dart';
import '../../../../core/widgets/selectable_chip.dart';
import '../../../../core/widgets/sticky_bottom_bar.dart';
import '../widgets/calendar_grid.dart';

enum ScheduleType { pickup, delivery }

class SchedulePage extends StatefulWidget {
  final ScheduleType type;

  const SchedulePage({super.key, required this.type});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  DateTime _selectedDate = DateTime.now();
  int? _selectedTimeSlotIndex;
  final TextEditingController _noteController = TextEditingController();

  final List<String> _timeSlots = [
    "08:00 AM - 11:00 AM",
    "11:00 AM - 02:00 PM",
    "02:00 PM - 05:00 PM",
    "05:00 PM - 08:00 PM",
  ];

  bool get _isPickup => widget.type == ScheduleType.pickup;

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBarFactory.build(
        context,
        title: _isPickup ? "Pick-up" : "Delivery",
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: Container(
              padding: EdgeInsets.all(8.r),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.more_vert,
                color: AppColors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CalendarGrid(
                    selectedDate: _selectedDate,
                    onDateSelected: (date) =>
                        setState(() => _selectedDate = date),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Selected Date:  ${_formatSelectedDate()}",
                    style: AppTextStyles.sectionLabel,
                  ),
                  SizedBox(height: 24.h),

                  Text("Select Time Slot", style: AppTextStyles.sectionTitle),
                  SizedBox(height: 12.h),
                  Wrap(
                    spacing: 10.w,
                    runSpacing: 12.h,
                    children: List.generate(_timeSlots.length, (index) {
                      return SelectableChip(
                        label: _timeSlots[index],
                        isSelected: _selectedTimeSlotIndex == index,
                        onTap: () =>
                            setState(() => _selectedTimeSlotIndex = index),
                      );
                    }),
                  ),
                  SizedBox(height: 24.h),

                  Text("Note:", style: AppTextStyles.sectionLabel),
                  SizedBox(height: 8.h),
                  TextField(
                    controller: _noteController,
                    maxLines: 2,
                    decoration: InputDecoration(
                      hintText: "Type something here...",
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 13.sp,
                      ),
                      filled: true,
                      fillColor: AppColors.cardBackground,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.r),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 14.h,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Action Bar
          StickyBottomBar(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Total:", style: AppTextStyles.caption),
                    Text(
                      "\$80 USD",
                      style: AppTextStyles.pageTitle.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 24.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_isPickup) {
                        context.pushNamed('deliverySchedule');
                      } else {
                        context.pushNamed('payment');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.white,
                      minimumSize: Size(0, 50.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      _isPickup ? "Delivery" : "Proceed to Payment",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatSelectedDate() {
    const days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return "${days[_selectedDate.weekday - 1]} ${_selectedDate.day} ${months[_selectedDate.month - 1]} ${_selectedDate.year}";
  }
}
