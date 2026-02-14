import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:laundry/core/widgets/selectable_chip.dart';

/// A horizontal row of [SelectableChip]s that acts like a tab bar.
///
/// Eliminates the repeated tab-bar pattern across pages
/// (OrdersPage, BasketPage, WalletPage, etc.).
///
/// Usage:
/// ```dart
/// ChipTabBar(
///   tabs: ["Washing", "Dry Cleaning", "Ironing"],
///   selectedIndex: _tabController.index,
///   onTap: (i) => _tabController.animateTo(i),
/// )
/// ```
class ChipTabBar extends StatelessWidget {
  final List<String> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTap;
  final bool expanded;
  final ScrollPhysics? scrollPhysics;
  final double? fontSize;

  const ChipTabBar({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTap,
    this.expanded = true,
    this.scrollPhysics,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    if (expanded) {
      return Row(
        children: List.generate(tabs.length, (index) {
          return Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: SelectableChip(
                label: tabs[index],
                isSelected: selectedIndex == index,
                onTap: () => onTap(index),
                fontSize: fontSize,
                padding: EdgeInsets.symmetric(vertical: 10.h),
              ),
            ),
          );
        }),
      );
    }

    return SizedBox(
      height: 40.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: scrollPhysics,
        itemCount: tabs.length,
        separatorBuilder: (_, _) => SizedBox(width: 12.w),
        itemBuilder: (_, index) {
          return SelectableChip(
            label: tabs[index],
            isSelected: selectedIndex == index,
            onTap: () => onTap(index),
            fontSize: fontSize,
          );
        },
      ),
    );
  }
}
