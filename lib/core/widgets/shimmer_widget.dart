import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Shimmer loading effect - no extra package needed
///
/// Usage:
///   ShimmerWidget.rectangular(height: 100.h)
///   ShimmerWidget.circular(size: 48.h)
///
///   // For a list skeleton:
///   ListView.builder(
///     itemCount: 5,
///     itemBuilder: (_, __) => const PostItemSkeleton(),
///   )
class ShimmerWidget extends StatefulWidget {
  final double width;
  final double height;
  final BorderRadius borderRadius;

  const ShimmerWidget._({
    required this.width,
    required this.height,
    required this.borderRadius,
  });

  /// Rectangular shimmer (for text, cards, images)
  factory ShimmerWidget.rectangular({
    double width = double.infinity,
    required double height,
    double radius = 8,
  }) {
    return ShimmerWidget._(
      width: width,
      height: height,
      borderRadius: BorderRadius.circular(radius),
    );
  }

  /// Circular shimmer (for avatars, icons)
  factory ShimmerWidget.circular({required double size, Key? key}) {
    return ShimmerWidget._(
      width: size,
      height: size,
      borderRadius: BorderRadius.circular(size / 2),
    );
  }

  @override
  State<ShimmerWidget> createState() => _ShimmerWidgetState();
}

class _ShimmerWidgetState extends State<ShimmerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
    _animation = Tween<double>(begin: -2, end: 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDark ? Colors.grey[800]! : Colors.grey[300]!;
    final highlightColor = isDark ? Colors.grey[700]! : Colors.grey[100]!;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius,
            gradient: LinearGradient(
              begin: Alignment(_animation.value - 1, 0),
              end: Alignment(_animation.value + 1, 0),
              colors: [baseColor, highlightColor, baseColor],
            ),
          ),
        );
      },
    );
  }
}

/// Example skeleton for a list item card
/// Copy and modify this for your own skeletons
class ListItemSkeleton extends StatelessWidget {
  const ListItemSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShimmerWidget.rectangular(height: 12.h, width: 80.w),
            SizedBox(height: 12.h),
            ShimmerWidget.rectangular(height: 16.h),
            SizedBox(height: 8.h),
            ShimmerWidget.rectangular(height: 16.h, width: 200.w),
            SizedBox(height: 12.h),
            ShimmerWidget.rectangular(height: 12.h),
            SizedBox(height: 4.h),
            ShimmerWidget.rectangular(height: 12.h, width: 150.w),
          ],
        ),
      ),
    );
  }
}
