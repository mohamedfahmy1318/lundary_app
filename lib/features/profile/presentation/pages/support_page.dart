import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:laundry/core/di/injection_container.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_bar_factory.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../data/models/ticket_model.dart';
import '../cubit/support_cubit.dart';
import '../cubit/support_state.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SupportCubit>()..loadTickets(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBarFactory.build(
          context,
          title: "Support",
          onBack: () => context.pop(),
        ),
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
                child: BlocBuilder<SupportCubit, SupportState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (msg) => Center(child: Text(msg, style: const TextStyle(color: Colors.red))),
                      loaded: (tickets) {
                        if (tickets.isEmpty) {
                          return Center(
                            child: Text(
                              "You haven't opened any tickets yet.",
                              style: AppTextStyles.bodyMedium,
                            ),
                          );
                        }
                        return ListView.separated(
                          itemCount: tickets.length,
                          separatorBuilder: (_, _) => SizedBox(height: 16.h),
                          itemBuilder: (_, index) => _TicketCard(ticket: tickets[index]),
                        );
                      },
                      orElse: () => const SizedBox.shrink(),
                    );
                  },
                ),
              ),
              SizedBox(height: 16.h),
              Builder(
                builder: (context) {
                  return CustomButton(
                    text: "Open a ticket",
                    onPressed: () async {
                      await context.pushNamed('newTicket');
                      if (context.mounted) {
                        context.read<SupportCubit>().loadTickets();
                      }
                    },
                    prefix: const Icon(Icons.add, color: AppColors.white),
                  );
                }
              ),
              SizedBox(height: 20.h),
            ],
          ),
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
    final bool isOpen = ticket.status == TicketStatus.open || ticket.status == TicketStatus.inProgress;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                ticket.ticketNumber,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: isOpen ? Colors.orange.withAlpha(50) : AppColors.success.withAlpha(50),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  isOpen ? "Open" : "Closed",
                  style: AppTextStyles.caption.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isOpen ? Colors.orange[800] : AppColors.success,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(ticket.subject, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
          SizedBox(height: 4.h),
          Text(
            ticket.description, 
            style: AppTextStyles.caption.copyWith(color: Colors.grey[600]),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Priority: ${ticket.priority.toUpperCase()}", style: AppTextStyles.captionSmall),
              Text(_formatDate(ticket.createdAt), style: AppTextStyles.captionSmall),
            ],
          )
        ],
      ),
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return "${date.month}/${date.day}/${date.year}";
    } catch (_) {
      return dateString.split('T').first;
    }
  }
}
