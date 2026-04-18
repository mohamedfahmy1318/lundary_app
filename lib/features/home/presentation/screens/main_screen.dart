import 'package:flutter/material.dart';
import 'package:laundry/features/home/presentation/screens/home_tab.dart';
import 'package:laundry/features/home/presentation/widgets/custom_bottom_nav_bar.dart';
import 'package:laundry/features/orders/presentation/pages/orders_page.dart';
import 'package:laundry/features/profile/presentation/pages/profile_page.dart';

class MainScreen extends StatefulWidget {
  final int initialIndex;

  const MainScreen({super.key, this.initialIndex = 0});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _currentIndex;

  /// Controls nav-bar opacity: fades while scrolling, returns on idle.
  double _navBarOpacity = 1.0;

  final List<Widget> _tabs = const [HomeTab(), OrdersPage(), ProfilePage()];

  @override
  void initState() {
    super.initState();
    _currentIndex = _normalizedIndex(widget.initialIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollStartNotification) {
            _setNavBarOpacity(0.4);
          } else if (notification is ScrollEndNotification) {
            _setNavBarOpacity(1.0);
          }
          return false;
        },
        child: _tabs[_currentIndex],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        opacity: _navBarOpacity,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }

  void _setNavBarOpacity(double value) {
    if (_navBarOpacity != value) setState(() => _navBarOpacity = value);
  }

  int _normalizedIndex(int index) {
    if (index < 0 || index >= _tabs.length) {
      return 0;
    }
    return index;
  }
}
