import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/core/constants/app_colors.dart';

/// A floating capsule-shaped bottom navigation bar with a center notch.
///
/// [opacity] controls the bar transparency (0.0 → invisible, 1.0 → solid).
/// Pass icons / labels via the fixed 4-tab layout.
class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final double opacity;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.opacity = 1.0,
  });

  // ── Tab definitions (easy to modify later) ──
  static const _tabs = [
    _TabData(Icons.home_rounded, 'Home'),
    _TabData(Icons.receipt_long_rounded, 'Orders'),
    _TabData(Icons.person_outline_rounded, 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 250),
      opacity: opacity,
      child: Container(
        height: 68.h,
        margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 20.h),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Background shape
            Positioned.fill(
              child: CustomPaint(
                painter: CustomNavBarPainter(color: AppColors.primary),
              ),
            ),
            // Icons row
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(_tabs.length, (i) {
                  // Insert spacer in the middle for the notch gap
                  if (i == 2) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(width: 36.w),
                        _NavBarIcon(
                          icon: _tabs[i].icon,
                          label: _tabs[i].label,
                          isSelected: currentIndex == i,
                          onTap: () => onTap(i),
                        ),
                      ],
                    );
                  }
                  return _NavBarIcon(
                    icon: _tabs[i].icon,
                    label: _tabs[i].label,
                    isSelected: currentIndex == i,
                    onTap: () => onTap(i),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Private helpers ─────────────────────────────────────────────────────────

class _TabData {
  final IconData icon;
  final String label;
  const _TabData(this.icon, this.label);
}

class _NavBarIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavBarIcon({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 56.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: EdgeInsets.all(isSelected ? 8.r : 0),
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isSelected ? AppColors.primary : Colors.white70,
                size: 22.sp,
              ),
            ),
            if (!isSelected) ...[
              SizedBox(height: 2.h),
              Text(
                label,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ── Custom Painter ──────────────────────────────────────────────────────────

/// Draws a capsule with a smooth "Up → Down → Up" notch in the top center.

class CustomNavBarPainter extends CustomPainter {
  final Color color;
  CustomNavBarPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();

    // إعدادات القياسات (العب في دول عشان تظبط الشكل اللي في دماغك)
    double r = size.height / 2; // تدويرة الكبسولة من الجناب
    double cx = size.width / 2; // المنتصف
    double w = 85.0; // عرض منطقة الكيرف كله
    double shoulderHeight = 10.0; // ارتفاع "الكتف" (الطلعة اللي فوق)
    double dipDepth = 10.0; // عمق "الحفرة" (النزولة اللي تحت)

    // 1. نبدأ من الشمال
    path.moveTo(0, r);
    path.arcToPoint(Offset(r, 0), radius: Radius.circular(r), clockwise: true);

    // 2. خط مستقيم لحد قبل منطقة الكيرف
    path.lineTo(cx - w / 2, 0);

    // 3. الكيرف السحري (نص شمال)
    // ده بيعمل حرف S ناعم: يطلع لفوق (-y) وبعدين ينزل لتحت (+y)
    path.cubicTo(
      cx - (w * 0.4),
      -shoulderHeight, // Control Point 1: شد الخط لفوق (الكتف)
      cx - (w * 0.2),
      dipDepth, // Control Point 2: شد الخط لتحت (الحفرة)
      cx,
      dipDepth, // End Point: قاع المنتصف
    );

    // 4. الكيرف السحري (نص يمين) - عكس اللي فات
    path.cubicTo(
      cx + (w * 0.2),
      dipDepth, // Control Point 1: لسة تحت
      cx + (w * 0.4),
      -shoulderHeight, // Control Point 2: شد لفوق تاني (الكتف اليمين)
      cx + w / 2,
      0, // End Point: رجعنا مستقيم
    );

    // 5. كمل باقي الشكل
    path.lineTo(size.width - r, 0);
    path.arcToPoint(
      Offset(size.width, r),
      radius: Radius.circular(r),
      clockwise: true,
    );
    path.arcToPoint(
      Offset(size.width - r, size.height),
      radius: Radius.circular(r),
      clockwise: true,
    );
    path.lineTo(r, size.height);
    path.arcToPoint(Offset(0, r), radius: Radius.circular(r), clockwise: true);

    path.close();

    // الظل عشان يبان المجسم
    canvas.drawShadow(path, Colors.black26, 6, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
