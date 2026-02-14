import 'package:flutter/widgets.dart';

/// Detect screen type and build responsive layouts
///
/// Usage:
///   // Check screen type:
///   if (ResponsiveHelper.isMobile(context)) { ... }
///
///   // Responsive value:
///   final columns = ResponsiveHelper.value<`int`>(
///     context,
///     mobile: 2,
///     tablet: 3,
///     desktop: 4,
///   );
///
///   // Responsive builder widget:
///   ResponsiveBuilder(
///     mobile: (context) => MobileLayout(),
///     tablet: (context) => TabletLayout(),
///   )
abstract class ResponsiveHelper {
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 1024;

  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < mobileBreakpoint;

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width >= mobileBreakpoint && width < tabletBreakpoint;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= tabletBreakpoint;

  /// Returns a value based on screen size
  static T value<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    if (isDesktop(context)) return desktop ?? tablet ?? mobile;
    if (isTablet(context)) return tablet ?? mobile;
    return mobile;
  }
}

/// Widget that builds different layouts based on screen size
class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context) mobile;
  final Widget Function(BuildContext context)? tablet;
  final Widget Function(BuildContext context)? desktop;

  const ResponsiveBuilder({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    if (ResponsiveHelper.isDesktop(context) && desktop != null) {
      return desktop!(context);
    }
    if (ResponsiveHelper.isTablet(context) && tablet != null) {
      return tablet!(context);
    }
    return mobile(context);
  }
}
