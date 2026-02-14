import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/app_bar_factory.dart';
import '../../../../core/widgets/chip_tab_bar.dart';
import '../widgets/wallet_tab.dart';
import '../widgets/family_tab.dart';
import '../widgets/cards_tab.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = ["Wallet", "Family", "Cards"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBarFactory.build(context, title: "E-Wallet & Payment Methods"),
      body: Column(
        children: [
          SizedBox(height: 12.h),

          // Tab Switcher
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: ChipTabBar(
              tabs: _tabs,
              selectedIndex: _tabController.index,
              onTap: (i) => _tabController.animateTo(i),
            ),
          ),

          SizedBox(height: 16.h),

          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [WalletTab(), FamilyTab(), CardsTab()],
            ),
          ),
        ],
      ),
    );
  }
}
