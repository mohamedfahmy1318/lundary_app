import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:laundry/features/select_address/presentation/screens/map_address_picker_screen.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_bar_factory.dart';
import '../../../../core/widgets/selectable_chip.dart';
import '../../../../core/widgets/sticky_bottom_bar.dart';
import '../../../../core/di/injection_container.dart';
import '../cubit/basket_cubit.dart';
import '../cubit/timeslots_cubit.dart';
import '../cubit/timeslots_state.dart';
import '../widgets/calendar_grid.dart';

enum ScheduleType { pickup, delivery }

class SchedulePage extends StatefulWidget {
  final ScheduleType type;
  final Map<String, String>? pickupData;

  const SchedulePage({super.key, required this.type, this.pickupData});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  DateTime _selectedDate = DateTime.now();
  DateTime? _pickupDateForDelivery;
  int? _selectedTimeSlotIndex;
  String? _selectedTimeSlotString;
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  late final TimeslotsCubit _timeslotsCubit;

  bool get _isPickup => widget.type == ScheduleType.pickup;

  @override
  void initState() {
    super.initState();

    _pickupDateForDelivery = _parsePickupDate();
    if (!_isPickup && _pickupDateForDelivery != null) {
      _selectedDate = _dateOnly(
        _pickupDateForDelivery!,
      ).add(const Duration(days: 1));
    }

    _timeslotsCubit =
        getIt<TimeslotsCubit>()..fetchTimeslots(_getDateString(_selectedDate));

    final initialAddress =
        _isPickup
            ? (widget.pickupData?['pickupAddress'] ?? '')
            : (widget.pickupData?['deliveryAddress'] ?? '');
    _addressController.text = initialAddress;
  }

  DateTime _dateOnly(DateTime value) {
    return DateTime(value.year, value.month, value.day);
  }

  DateTime? _parsePickupDate() {
    final raw = widget.pickupData?['pickupDate'];
    if (raw == null || raw.trim().isEmpty) {
      return null;
    }

    try {
      return DateTime.parse(raw);
    } catch (_) {
      return null;
    }
  }

  bool _isDeliveryDateBeforeAllowedWindow(DateTime date) {
    if (_isPickup) {
      return false;
    }

    final pickupDate = _pickupDateForDelivery;
    if (pickupDate == null) {
      return false;
    }

    final minDeliveryDate = _dateOnly(pickupDate).add(const Duration(days: 1));
    return _dateOnly(date).isBefore(minDeliveryDate);
  }

  void _showInvalidDeliveryDateMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Delivery date must be at least one day after pickup date.',
        ),
      ),
    );
  }

  String _getDateString(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _noteController.dispose();
    _addressController.dispose();
    _timeslotsCubit.close();
    super.dispose();
  }

  Future<void> _openMapPicker() async {
    final selectedAddress = await Navigator.of(context).push<String>(
      MaterialPageRoute(
        builder:
            (_) => MapAddressPickerScreen(
              title:
                  _isPickup
                      ? 'Select Pickup Address'
                      : 'Select Delivery Address',
            ),
      ),
    );

    if (!mounted || selectedAddress == null || selectedAddress.trim().isEmpty) {
      return;
    }

    setState(() {
      _addressController.text = selectedAddress.trim();
    });
  }

  @override
  Widget build(BuildContext context) {
    final basketTotal = getIt<BasketCubit>().totalAmount;

    return BlocProvider.value(
      value: _timeslotsCubit,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBarFactory.build(
          context,
          onBack: () => context.pop(),
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
                      onDateSelected: (date) {
                        if (_isDeliveryDateBeforeAllowedWindow(date)) {
                          _showInvalidDeliveryDateMessage();
                          return;
                        }

                        setState(() {
                          _selectedDate = date;
                          _selectedTimeSlotIndex = null;
                          _selectedTimeSlotString = null;
                        });
                        _timeslotsCubit.fetchTimeslots(_getDateString(date));
                      },
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "Selected Date:  ${_formatSelectedDate()}",
                      style: AppTextStyles.sectionLabel,
                    ),
                    SizedBox(height: 24.h),

                    Text("Select Time Slot", style: AppTextStyles.sectionTitle),
                    SizedBox(height: 12.h),
                    BlocBuilder<TimeslotsCubit, TimeslotsState>(
                      builder: (context, state) {
                        return state.when(
                          initial: () => const SizedBox.shrink(),
                          loading:
                              () => const Center(
                                child: CircularProgressIndicator(),
                              ),
                          error:
                              (msg) => Text(
                                msg,
                                style: const TextStyle(color: Colors.red),
                              ),
                          loaded: (slots) {
                            final currentDayName = _getDayName(
                              _selectedDate.weekday,
                            );
                            final filteredSlots =
                                slots.where((slot) {
                                  if (!slot.isActive) {
                                    return false;
                                  }
                                  if (!slot.supportsDay(currentDayName)) {
                                    return false;
                                  }

                                  if (_isPickup) {
                                    return slot.supportsPickupType();
                                  } else {
                                    return slot.supportsDeliveryType();
                                  }
                                }).toList();

                            if (filteredSlots.isEmpty) {
                              return const Text(
                                "No available time slots for this date.",
                              );
                            }
                            return Wrap(
                              spacing: 10.w,
                              runSpacing: 12.h,
                              children: List.generate(filteredSlots.length, (
                                index,
                              ) {
                                final slot = filteredSlots[index];
                                final label =
                                    "${slot.startTime} - ${slot.endTime}";
                                return SelectableChip(
                                  label: label,
                                  isSelected: _selectedTimeSlotIndex == index,
                                  onTap:
                                      () => setState(() {
                                        _selectedTimeSlotIndex = index;
                                        _selectedTimeSlotString = label;
                                      }),
                                );
                              }),
                            );
                          },
                        );
                      },
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

                    SizedBox(height: 20.h),
                    Text("Address:", style: AppTextStyles.sectionLabel),
                    SizedBox(height: 8.h),
                    TextField(
                      controller: _addressController,
                      maxLines: 2,
                      decoration: InputDecoration(
                        hintText:
                            _isPickup
                                ? "Enter pickup address..."
                                : "Enter delivery address...",
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
                    SizedBox(height: 10.h),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: _openMapPicker,
                        icon: const Icon(Icons.map_outlined),
                        label: const Text('Select Address on Map'),
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
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/images/icon_price.png',
                            width: 16.w,
                            height: 16.w,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            basketTotal.toStringAsFixed(2),
                            style: AppTextStyles.pageTitle.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(width: 24.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_selectedTimeSlotIndex == null ||
                            _selectedTimeSlotString == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please select a time slot.'),
                            ),
                          );
                          return;
                        }

                        final address = _addressController.text.trim();
                        if (address.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Please add address or pick from maps.',
                              ),
                            ),
                          );
                          return;
                        }

                        final dateStr = _getDateString(_selectedDate);
                        final timeSlot = _selectedTimeSlotString!.replaceAll(
                          ' ',
                          '',
                        );

                        if (_isPickup) {
                          context.pushNamed(
                            'deliverySchedule',
                            extra: {
                              'pickupDate': dateStr,
                              'pickupTimeSlot': timeSlot,
                              'pickupAddress': address,
                              'pickupNotes': _noteController.text,
                            },
                          );
                        } else {
                          if (_isDeliveryDateBeforeAllowedWindow(
                            _selectedDate,
                          )) {
                            _showInvalidDeliveryDateMessage();
                            return;
                          }

                          context.pushNamed(
                            'payment',
                            extra: {
                              ...?widget.pickupData,
                              'deliveryDate': dateStr,
                              'deliveryTimeSlot': timeSlot,
                              'deliveryAddress': address,
                              'deliveryNotes': _noteController.text,
                            },
                          );
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
      ),
    );
  }

  String _getDayName(int weekday) {
    const days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    return days[weekday - 1];
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
