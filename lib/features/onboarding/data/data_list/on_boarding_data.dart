import 'package:laundry/core/constants/app_assets.dart';
import 'package:laundry/features/onboarding/data/models/on_boarding_model.dart';

List<OnBoardingModel> onboardingPages = [
  OnBoardingModel(
    title: 'Hotel-Quality\nLaundry Delivered',
    description:
        'Professional garment care using eco-friendly\n processes trusted by premium environments and\n designed for your home',
    image: AppAssets.onBoardingImg,
    buttonText: 'Next',
  ),
  OnBoardingModel(
    title: 'EffortlessPickup & Delivery',
    description:
        'Choose your time slot, select services per item, and\n track every step from pickup to perfect finish.',
    image: AppAssets.onBoardingImg,
    buttonText: 'Next',
  ),
  OnBoardingModel(
    title: 'Care You Can Trust',
    description:
        'Quality guaranteed. Eco-friendly processes. Share wallets and subscriptions with your family all in one \naccount',
    image: AppAssets.onBoardingImg,
    buttonText: 'Get Started',
  ),
];
