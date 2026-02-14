import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:laundry/core/constants/app_colors.dart';
import 'package:laundry/core/widgets/app_bar_factory.dart';
import 'package:laundry/features/select_address/presentation/widgets/address_bottom_card.dart';
import 'package:laundry/features/select_address/presentation/widgets/map_placeholder.dart';

class SelectAddressScreen extends StatelessWidget {
  const SelectAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBarFactory.build(context, title: 'Select Address'),
      body: Column(
        children: [
          // Map area — takes all available space
          const Expanded(child: MapPlaceholder()),

          // Bottom card
          AddressBottomCard(
            nickname: 'Home 1',
            hint: 'Please select your Pickup & Delivery zone',
            onSave: () {
              // TODO: handle save when backend is ready
              context.goNamed('main');
            },
            onCancel: () {
              context.pop();
            },
          ),
        ],
      ),
    );
  }
}
