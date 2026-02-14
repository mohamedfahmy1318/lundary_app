import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/features/home/presentation/widgets/category_chip.dart';
import 'package:laundry/features/home/presentation/widgets/home_app_bar.dart';
import 'package:laundry/features/home/presentation/widgets/promo_banner.dart';
import 'package:laundry/features/home/presentation/widgets/quick_pick_card.dart';
import 'package:laundry/features/home/presentation/widgets/section_header.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int _selectedCategory = 0;

  // ── Dummy data (will come from API later) ──

  static const _categories = [
    {'label': 'Washing', 'icon': Icons.local_laundry_service},
    {'label': 'Ironing', 'icon': Icons.iron},
    {'label': 'Dry Clean', 'icon': Icons.dry_cleaning},
    {'label': 'Special', 'icon': Icons.auto_awesome},
  ];

  final List<Map<String, dynamic>> _quickPicks = [
    {'name': 'Shirt', 'category': 'Washing', 'qty': 1},
    {'name': 'Dress', 'category': 'Dry Cleaning', 'qty': 2},
    {'name': 'Pants', 'category': 'Washing', 'qty': 0},
    {'name': 'Jacket', 'category': 'Dry Cleaning', 'qty': 0},
  ];

  // ── Build ──

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 110.h), // space for floating nav bar
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeAppBar(
                location: 'Mirdif, Dubai',
                cartCount: 6,
                onCartTap: () => context.pushNamed('basket'),
              ),
              SizedBox(height: 16.h),
              _buildPromoBanner(),
              SizedBox(height: 12.h),
              _buildDots(),
              SizedBox(height: 24.h),
              _buildCategories(),
              SizedBox(height: 24.h),
              _buildQuickPicks(),
            ],
          ),
        ),
      ),
    );
  }

  // ── Sections ──

  Widget _buildPromoBanner() {
    return const PromoBanner(title: 'Welcome Offers', discount: '50%');
  }

  Widget _buildDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (i) {
        final isActive = i == 2;
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 3.w),
          width: isActive ? 10.w : 8.w,
          height: isActive ? 10.h : 8.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? Colors.blue : Colors.grey[400],
          ),
        );
      }),
    );
  }

  Widget _buildCategories() {
    return Column(
      children: [
        SectionHeader(title: 'Categories', onViewAll: () {}),
        SizedBox(height: 12.h),
        SizedBox(
          height: 48.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            itemCount: _categories.length,
            separatorBuilder: (_, _) => SizedBox(width: 10.w),
            itemBuilder: (_, index) {
              final cat = _categories[index];
              return CategoryChip(
                label: cat['label'] as String,
                icon: cat['icon'] as IconData,
                isSelected: index == _selectedCategory,
                onTap: () => setState(() => _selectedCategory = index),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildQuickPicks() {
    return Column(
      children: [
        SectionHeader(title: 'Quick Picks', onViewAll: () {}),
        SizedBox(height: 12.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12.h,
              crossAxisSpacing: 12.w,
              childAspectRatio: 0.70,
            ),
            itemCount: _quickPicks.length,
            itemBuilder: (_, index) {
              final item = _quickPicks[index];
              return QuickPickCard(
                name: item['name'] as String,
                category: item['category'] as String,
                quantity: item['qty'] as int,
                onIncrement: () => setState(() => _quickPicks[index]['qty']++),
                onDecrement: () => setState(() {
                  if ((_quickPicks[index]['qty'] as int) > 0) {
                    _quickPicks[index]['qty']--;
                  }
                }),
              );
            },
          ),
        ),
      ],
    );
  }
}
