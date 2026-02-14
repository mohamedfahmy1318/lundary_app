import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:laundry/core/theme/app_text_styles.dart';
import 'package:laundry/core/utils/app_extensions.dart';
import 'package:laundry/features/onboarding/presentation/widgets/on_boarding_item.dart';
import 'package:laundry/features/onboarding/data/data_list/on_boarding_data.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController(viewportFraction: .96);
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              context.goNamed('login');
            },
            child: Text('Skip', style: AppTextStyles.onBoardingDescription),
          ),
        ],
      ),
      body: PageView.builder(
        itemCount: onboardingPages.length,
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          return OnBoardingItem(
            onBoardingModel: onboardingPages[index],
            currentIndex: _currentIndex,
            totalPages: onboardingPages.length,
            onButtonPressed: () {
              if (index < onboardingPages.length - 1) {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                );
              } else {
                context.goNamed('login');
              }
            },
          ).paddingSymmetric(horizontal: 18.w);
        },
      ),
    );
  }
}
