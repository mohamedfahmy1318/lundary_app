import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:laundry/core/di/injection_container.dart';
import 'package:laundry/core/theme/app_text_styles.dart';
import 'package:laundry/core/utils/app_extensions.dart';
import 'package:laundry/features/onboarding/presentation/widgets/on_boarding_empty_view.dart';
import 'package:laundry/features/onboarding/presentation/widgets/on_boarding_error_view.dart';
import 'package:laundry/features/onboarding/presentation/widgets/on_boarding_item.dart';
import 'package:laundry/features/onboarding/presentation/widgets/on_boarding_loading_view.dart';
import '../cubit/on_boarding_cubit.dart';
import '../cubit/on_boarding_state.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<OnBoardingCubit>()..loadOnBoarding(),
      child: const _OnBoardingView(),
    );
  }
}

class _OnBoardingView extends StatefulWidget {
  const _OnBoardingView();

  @override
  State<_OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<_OnBoardingView> {
  final PageController _pageController = PageController(viewportFraction: .96);
  int _currentIndex = 0;

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
      body: BlocBuilder<OnBoardingCubit, OnBoardingState>(
        builder: (context, state) {
          return state.maybeWhen(
            loading: OnBoardingLoadingView.new,
            error: (msg) => OnBoardingErrorView(message: msg),
            loaded: (slides) {
              if (slides.isEmpty) {
                return const OnBoardingEmptyView();
              }
              return PageView.builder(
                itemCount: slides.length,
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  final isLast = index == slides.length - 1;
                  return OnBoardingItem(
                    slide: slides[index],
                    currentIndex: _currentIndex,
                    totalPages: slides.length,
                    buttonText: isLast ? "Get Started" : "Next",
                    onButtonPressed: () {
                      if (!isLast) {
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
              );
            },
            orElse: () => const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}
