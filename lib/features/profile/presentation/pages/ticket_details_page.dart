import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/core/constants/app_colors.dart';
import 'package:laundry/core/di/injection_container.dart';
import 'package:laundry/core/theme/app_text_styles.dart';
import 'package:laundry/core/widgets/app_bar_factory.dart';
import 'package:laundry/core/widgets/custom_button.dart';
import 'package:laundry/features/profile/domain/entities/ticket_entity.dart';
import 'package:laundry/features/profile/presentation/cubit/ticket_details_cubit.dart';
import 'package:laundry/features/profile/presentation/cubit/ticket_details_state.dart';
import 'package:laundry/features/profile/presentation/widgets/ticket_details/ticket_details_widgets.dart';

class TicketDetailsPage extends StatelessWidget {
  final int ticketId;

  const TicketDetailsPage({super.key, required this.ticketId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<TicketDetailsCubit>()..loadTicket(ticketId),
      child: _TicketDetailsView(ticketId: ticketId),
    );
  }
}

class _TicketDetailsView extends StatefulWidget {
  final int ticketId;

  const _TicketDetailsView({required this.ticketId});

  @override
  State<_TicketDetailsView> createState() => _TicketDetailsViewState();
}

class _TicketDetailsViewState extends State<_TicketDetailsView> {
  final TextEditingController _replyController = TextEditingController();

  @override
  void dispose() {
    _replyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TicketDetailsCubit, TicketDetailsState>(
      listenWhen:
          (previous, current) =>
              previous.errorMessage != current.errorMessage ||
              previous.actionMessage != current.actionMessage,
      listener: (context, state) {
        final message = state.errorMessage;
        if (message != null && message.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message), backgroundColor: AppColors.error),
          );
          context.read<TicketDetailsCubit>().clearMessages();
          return;
        }

        final actionMessage = state.actionMessage;
        if (actionMessage != null && actionMessage.isNotEmpty) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(actionMessage)));
          _replyController.clear();
          context.read<TicketDetailsCubit>().clearMessages();
        }
      },
      builder: (context, state) {
        final ticket = state.ticket;
        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBarFactory.build(
            context,
            title: 'Ticket Details',
            onBack: () => Navigator.of(context).pop(),
          ),
          body: _buildBody(context, state, ticket),
        );
      },
    );
  }

  Widget _buildBody(
    BuildContext context,
    TicketDetailsState state,
    TicketEntity? ticket,
  ) {
    if (state.isLoading && ticket == null) {
      return const Center(child: CircularProgressIndicator());
    }

    if (ticket == null) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Failed to load ticket details',
                style: AppTextStyles.bodyMedium,
              ),
              SizedBox(height: 12.h),
              CustomButton(
                text: 'Retry',
                width: 160.w,
                onPressed: () {
                  final cubit = context.read<TicketDetailsCubit>();
                  cubit.loadTicket(widget.ticketId);
                },
              ),
            ],
          ),
        ),
      );
    }

    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh:
                  () => context.read<TicketDetailsCubit>().loadTicket(
                    widget.ticketId,
                  ),
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                children: [
                  TicketSummaryCard(
                    ticket: ticket,
                    isClosing: state.isClosingTicket,
                    onClose: () => _confirmCloseTicket(context),
                  ),
                  SizedBox(height: 20.h),
                  if ((ticket.replies ?? []).isEmpty)
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: AppColors.cardBackground,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Text(
                        'No replies yet. Our team will respond soon.',
                        style: AppTextStyles.bodyRegular,
                      ),
                    )
                  else
                    ...ticket.replies!.map(
                      (reply) => TicketReplyBubble(reply: reply),
                    ),
                ],
              ),
            ),
          ),
          TicketReplyComposer(
            controller: _replyController,
            isClosed: ticket.isClosed,
            isSending: state.isSendingReply,
            onSend: () {
              context.read<TicketDetailsCubit>().sendReply(
                _replyController.text,
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _confirmCloseTicket(BuildContext context) async {
    final shouldClose = await showDialog<bool>(
      context: context,
      builder:
          (dialogContext) => AlertDialog(
            title: const Text('Close Ticket'),
            content: const Text(
              'Are you sure you want to close this ticket? You will not be able to reply after closing.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(false),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(dialogContext).pop(true),
                child: const Text('Close Ticket'),
              ),
            ],
          ),
    );

    if (shouldClose == true && context.mounted) {
      context.read<TicketDetailsCubit>().closeCurrentTicket();
    }
  }
}
