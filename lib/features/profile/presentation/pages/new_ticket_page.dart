import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:laundry/core/di/injection_container.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_bar_factory.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/selectable_chip.dart';
import '../cubit/support_cubit.dart';
import '../cubit/support_state.dart';

class NewTicketPage extends StatelessWidget {
  const NewTicketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SupportCubit>(),
      child: const _NewTicketView(),
    );
  }
}

class _NewTicketView extends StatefulWidget {
  const _NewTicketView();

  @override
  State<_NewTicketView> createState() => _NewTicketViewState();
}

class _NewTicketViewState extends State<_NewTicketView> {
  String? _selectedCategory;
  final TextEditingController _orderNumberController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  final List<String> _categories = [
    "order_issue",
    "delivery_problem",
    "quality_complaint",
    "refund_request",
    "payment_issue",
    "other",
  ];

  @override
  void dispose() {
    _orderNumberController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submitTicket() {
    if (_selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select a category.')));
      return;
    }
    if (_subjectController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter a subject.')));
      return;
    }
    if (_messageController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please describe your issue.')));
      return;
    }

    String finalSubject = _subjectController.text.trim();
    if (_orderNumberController.text.trim().isNotEmpty) {
      finalSubject += " - Order: ${_orderNumberController.text.trim()}";
    }

    context.read<SupportCubit>().createTicket(
      finalSubject,
      _messageController.text.trim(),
      "low", // default priority valid by backend
      _selectedCategory!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBarFactory.build(
        context,
        title: "New Ticket",
        onBack: () => context.pop(),
      ),
      body: BlocListener<SupportCubit, SupportState>(
        listener: (context, state) {
          state.maybeWhen(
            submissionSuccess: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Support ticket created successfully!')));
              context.pop();
            },
            error: (msg) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
            },
            orElse: () {},
          );
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Create Support Ticket", style: AppTextStyles.sectionTitle),
              SizedBox(height: 8.h),
              Text(
                "We're here to help. Describe your issue below.",
                style: AppTextStyles.bodyRegular,
              ),
              SizedBox(height: 30.h),

              // Categories
              Text("Select Category *", style: AppTextStyles.sectionLabel),
              SizedBox(height: 12.h),
              Wrap(
                spacing: 8.w,
                runSpacing: 12.h,
                children: _categories.map((category) {
                  return SelectableChip(
                    label: category.replaceAll('_', ' ').toUpperCase(),
                    isSelected: _selectedCategory == category,
                    onTap: () {
                      setState(() {
                        _selectedCategory = _selectedCategory == category ? null : category;
                      });
                    },
                  );
                }).toList(),
              ),

              SizedBox(height: 24.h),

              // Subject
              _buildLabeledField(
                label: "Subject *",
                hint: "e.g., Missing items in my bag",
                controller: _subjectController,
              ),
              SizedBox(height: 24.h),

              // Order Number
              _buildLabeledField(
                label: "Order Number (Optional)",
                hint: "e.g., #123456",
                controller: _orderNumberController,
              ),
              SizedBox(height: 24.h),

              // Description
              _buildLabeledField(
                label: "Describe Your Issue *",
                hint: "Please provide details about your issue...",
                maxLines: 5,
                controller: _messageController,
              ),
              
              SizedBox(height: 32.h),

              // Submit Button
              BlocBuilder<SupportCubit, SupportState>(
                builder: (context, state) {
                  final isSubmitting = state.maybeWhen(submitting: () => true, orElse: () => false);
                  return CustomButton(
                    text: isSubmitting ? "Submitting..." : "Submit Ticket",
                    onPressed: isSubmitting ? () {} : _submitTicket,
                  );
                },
              ),
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabeledField({
    required String label,
    required String hint,
    required TextEditingController controller,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.sectionLabel),
        SizedBox(height: 12.h),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[400], fontSize: 13.sp),
            filled: true,
            fillColor: AppColors.cardBackground,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: const BorderSide(color: AppColors.primary),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 16.h,
            ),
          ),
        ),
      ],
    );
  }
}
