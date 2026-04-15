import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:laundry/core/di/injection_container.dart';
import 'package:laundry/features/profile/domain/entities/ticket_lookup_option_entity.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_bar_factory.dart';
import '../../../../core/widgets/custom_button.dart';
import '../cubit/support_cubit.dart';
import '../cubit/support_state.dart';
import '../widgets/new_ticket/new_ticket_form_widgets.dart';

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
  String? _selectedCategoryValue;
  String? _selectedPriorityValue;

  List<TicketLookupOptionEntity> _categoryLookupOptions = const [];
  List<TicketLookupOptionEntity> _priorityLookupOptions = const [];

  bool _isLookupLoading = true;
  String? _lookupErrorMessage;

  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    unawaited(_loadLookups());
  }

  @override
  void dispose() {
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _loadLookups() async {
    _setLookupLoading();

    final lookups = await context.read<SupportCubit>().loadTicketLookups();

    if (!mounted) {
      return;
    }

    if (lookups == null) {
      _setLookupError('Unable to load support options. Please try again.');
      return;
    }

    _setLookupData(lookups);
  }

  void _setLookupLoading() {
    setState(() {
      _isLookupLoading = true;
      _lookupErrorMessage = null;
    });
  }

  void _setLookupError(String message) {
    setState(() {
      _isLookupLoading = false;
      _lookupErrorMessage = message;
    });
  }

  void _setLookupData(TicketLookups lookups) {
    setState(() {
      _categoryLookupOptions = lookups.categories;
      _priorityLookupOptions = lookups.priorities;
      _selectedCategoryValue ??=
          _categoryLookupOptions.isNotEmpty
              ? _categoryLookupOptions.first.value
              : null;
      _selectedPriorityValue ??=
          _priorityLookupOptions.isNotEmpty
              ? _priorityLookupOptions.first.value
              : null;
      _isLookupLoading = false;
      _lookupErrorMessage = null;
    });
  }

  void _onSubmitTicketPressed() {
    final validationError = _validationErrorMessage();
    if (validationError != null) {
      _showSnackBar(validationError);
      return;
    }

    context.read<SupportCubit>().createTicket(
      subject: _subjectController.text.trim(),
      message: _messageController.text.trim(),
      priority: _selectedPriorityValue!,
      category: _selectedCategoryValue!,
    );
  }

  String? _validationErrorMessage() {
    if (_isLookupLoading) {
      return 'Support options are still loading. Please wait.';
    }

    if (_selectedCategoryValue == null) {
      return 'Please select a category.';
    }

    if (_selectedPriorityValue == null) {
      return 'Please select a priority.';
    }

    if (_subjectController.text.trim().isEmpty) {
      return 'Please enter a subject.';
    }

    if (_messageController.text.trim().isEmpty) {
      return 'Please describe your issue.';
    }

    return null;
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _onCategorySelected(String value) {
    setState(() {
      _selectedCategoryValue = value;
    });
  }

  void _onPrioritySelected(String value) {
    setState(() {
      _selectedPriorityValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBarFactory.build(
        context,
        title: 'New Ticket',
        onBack: () => context.pop(),
      ),
      body: BlocListener<SupportCubit, SupportState>(
        listener: (context, state) {
          state.maybeWhen(
            submissionSuccess: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Support ticket created successfully!'),
                ),
              );
              context.pop();
            },
            error: (msg) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(msg)));
            },
            orElse: () {},
          );
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Create Support Ticket', style: AppTextStyles.sectionTitle),
              SizedBox(height: 8.h),
              Text(
                'We\'re here to help. Describe your issue below.',
                style: AppTextStyles.bodyRegular,
              ),
              SizedBox(height: 30.h),
              _buildLookupContent(),
              LabeledTicketInputField(
                label: 'Subject *',
                hint: 'e.g., Missing items in my bag',
                controller: _subjectController,
              ),
              SizedBox(height: 24.h),
              LabeledTicketInputField(
                label: 'Describe Your Issue *',
                hint: 'Please provide details about your issue...',
                maxLines: 5,
                controller: _messageController,
              ),
              SizedBox(height: 32.h),
              _buildSubmitButton(),
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLookupContent() {
    if (_isLookupLoading) {
      return Column(
        children: [
          const Center(child: CircularProgressIndicator()),
          SizedBox(height: 24.h),
        ],
      );
    }

    if (_lookupErrorMessage != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _lookupErrorMessage!,
            style: AppTextStyles.bodyRegular.copyWith(color: AppColors.error),
          ),
          SizedBox(height: 10.h),
          TextButton(onPressed: _loadLookups, child: const Text('Retry')),
          SizedBox(height: 24.h),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Select Category *', style: AppTextStyles.sectionLabel),
        SizedBox(height: 12.h),
        TicketLookupOptionGrid(
          options: _categoryLookupOptions,
          selectedValue: _selectedCategoryValue,
          onSelected: _onCategorySelected,
        ),
        SizedBox(height: 24.h),
        Text('Select Priority *', style: AppTextStyles.sectionLabel),
        SizedBox(height: 12.h),
        TicketLookupOptionGrid(
          options: _priorityLookupOptions,
          selectedValue: _selectedPriorityValue,
          onSelected: _onPrioritySelected,
        ),
        SizedBox(height: 24.h),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return BlocBuilder<SupportCubit, SupportState>(
      builder: (context, state) {
        final isSubmitting = state.maybeWhen(
          submitting: () => true,
          orElse: () => false,
        );

        return CustomButton(
          text: isSubmitting ? 'Submitting...' : 'Submit Ticket',
          onPressed:
              (isSubmitting || _isLookupLoading)
                  ? null
                  : _onSubmitTicketPressed,
        );
      },
    );
  }
}
