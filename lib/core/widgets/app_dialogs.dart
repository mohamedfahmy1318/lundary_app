import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:laundry/core/constants/app_colors.dart';
import 'package:laundry/core/widgets/custom_button.dart';

/// Reusable dialogs and bottom sheets
abstract class AppDialogs {
  /// Confirmation dialog (delete, logout, etc.)
  ///
  /// Usage:
  ///   final confirmed = await AppDialogs.confirm(
  ///     context,
  ///     title: 'Delete Item',
  ///     message: 'Are you sure you want to delete this?',
  ///   );
  ///   if (confirmed) { ... }
  static Future<bool> confirm(
    BuildContext context, {
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    Color? confirmColor,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(cancelText),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(
              foregroundColor: confirmColor ?? AppColors.error,
            ),
            child: Text(confirmText),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  /// Loading dialog (show while async operation)
  ///
  /// Usage:
  ///   AppDialogs.showLoading(context);
  ///   await doSomething();
  ///   AppDialogs.hideLoading(context);
  static void showLoading(BuildContext context, {String? message}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          content: Row(
            children: [
              const CircularProgressIndicator(),
              SizedBox(width: 20.w),
              Text(message ?? 'Please wait...'),
            ],
          ),
        ),
      ),
    );
  }

  static void hideLoading(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  /// Success / Error message dialog
  static Future<void> showMessage(
    BuildContext context, {
    required String title,
    required String message,
    bool isError = false,
  }) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Row(
          children: [
            Icon(
              isError ? Icons.error_outline : Icons.check_circle_outline,
              color: isError ? AppColors.error : AppColors.success,
            ),
            SizedBox(width: 8.w),
            Text(title),
          ],
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

/// Reusable bottom sheets
abstract class AppBottomSheets {
  /// Simple list selection bottom sheet
  ///
  /// Usage:
  ///   final selected = await AppBottomSheets.showSelection<`String`>(
  ///     context,
  ///     title: 'Choose City',
  ///     items: ['Cairo', 'Alex', 'Giza'],
  ///     itemLabel: (item) => item,
  ///   );
  static Future<T?> showSelection<T>(
    BuildContext context, {
    required String title,
    required List<T> items,
    required String Function(T) itemLabel,
    T? selectedItem,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 16.h),
            Text(title),
            SizedBox(height: 16.h),
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 300.h),
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: items.length,
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final item = items[index];
                  final isSelected = item == selectedItem;
                  return ListTile(
                    title: Text(
                      itemLabel(item),
                      style: TextStyle(
                        color: isSelected ? AppColors.primary : null,
                        fontWeight: isSelected ? FontWeight.w600 : null,
                      ),
                    ),
                    trailing: isSelected
                        ? const Icon(Icons.check, color: AppColors.primary)
                        : null,
                    onTap: () => Navigator.of(context).pop(item),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Bottom sheet with custom content
  ///
  /// Usage:
  ///   AppBottomSheets.show(
  ///     context,
  ///     title: 'Filter',
  ///     child: FilterWidget(),
  ///   );
  static Future<T?> show<T>(
    BuildContext context, {
    required String title,
    required Widget child,
    String? buttonText,
    VoidCallback? onButtonPressed,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
          top: 16.h,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 16.h),
            Text(title),
            SizedBox(height: 16.h),
            child,
            if (buttonText != null) ...[
              SizedBox(height: 16.h),
              CustomButton(text: buttonText, onPressed: onButtonPressed),
            ],
          ],
        ),
      ),
    );
  }
}
