import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_bar_factory.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../data/models/ticket_model.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBarFactory.build(context, title: "Support"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("My Support Tickets", style: AppTextStyles.sectionTitle),
            SizedBox(height: 8.h),
            Text(
              "View and manage your support requests",
              style: AppTextStyles.bodyRegular,
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: ListView.separated(
                itemCount: TicketModel.mockTickets.length,
                separatorBuilder: (_, _) => SizedBox(height: 16.h),
                itemBuilder: (_, index) =>
                    _TicketCard(ticket: TicketModel.mockTickets[index]),
              ),
            ),
            SizedBox(height: 16.h),
            CustomButton(
              text: "Open a ticket",
              onPressed: () => context.pushNamed('newTicket'),
              prefix: const Icon(Icons.add, color: AppColors.white),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}

class _TicketCard extends StatelessWidget {
  final TicketModel ticket;

  const _TicketCard({required this.ticket});

  @override
  Widget build(BuildContext context) {
    final isInProgress = ticket.status == TicketStatus.inProgress;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                ticket.id,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                isInProgress ? "In Progress" : "Closed",
                style: AppTextStyles.caption.copyWith(
                  fontWeight: FontWeight.w500,
                  color: isInProgress ? AppColors.warning : AppColors.success,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(ticket.title, style: AppTextStyles.bodyMedium),
          SizedBox(height: 4.h),
          Text(ticket.description, style: AppTextStyles.caption),
          SizedBox(height: 8.h),
          Text(_formatDate(ticket.date), style: AppTextStyles.captionSmall),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.month} ${date.day}, ${date.year} - ${date.hour}:${date.minute.toString().padLeft(2, '0')}";
  }
}
