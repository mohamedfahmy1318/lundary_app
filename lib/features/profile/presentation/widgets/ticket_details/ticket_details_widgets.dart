import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:laundry/core/constants/app_colors.dart';
import 'package:laundry/core/theme/app_text_styles.dart';
import 'package:laundry/core/widgets/custom_button.dart';
import 'package:laundry/features/profile/domain/entities/ticket_entity.dart';
import 'package:laundry/features/profile/domain/entities/ticket_reply_entity.dart';

class TicketSummaryCard extends StatelessWidget {
  final TicketEntity ticket;
  final bool isClosing;
  final VoidCallback onClose;

  const TicketSummaryCard({
    super.key,
    required this.ticket,
    required this.isClosing,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final isOpen = ticket.isOpen;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  ticket.ticketNumber,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
              ),
              _StatusBadge(isOpen: isOpen),
            ],
          ),
          SizedBox(height: 10.h),
          Text(ticket.subject, style: AppTextStyles.sectionLabel),
          SizedBox(height: 6.h),
          Text(ticket.description, style: AppTextStyles.bodyRegular),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Priority: ${ticket.priority.toUpperCase()}',
                style: AppTextStyles.caption,
              ),
              Text(
                TicketDateFormatter.dateOnly(ticket.updatedAt),
                style: AppTextStyles.caption,
              ),
            ],
          ),
          if (!ticket.isClosed) ...[
            SizedBox(height: 16.h),
            CustomButton(
              text: 'Close Ticket',
              isOutlined: true,
              isLoading: isClosing,
              onPressed: onClose,
            ),
          ],
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final bool isOpen;

  const _StatusBadge({required this.isOpen});

  @override
  Widget build(BuildContext context) {
    final color = isOpen ? Colors.orange[800]! : AppColors.success;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: color.withAlpha(40),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        isOpen ? 'Open' : 'Closed',
        style: AppTextStyles.caption.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class TicketReplyBubble extends StatelessWidget {
  final TicketReplyEntity reply;

  const TicketReplyBubble({super.key, required this.reply});

  @override
  Widget build(BuildContext context) {
    final isStaff = reply.isStaffReply;
    final isOptimistic = reply.id < 0;
    final textColor = isStaff ? AppColors.textPrimary : AppColors.white;
    final metaColor =
        isStaff ? AppColors.textSecondary : AppColors.white.withAlpha(210);

    return Align(
      alignment: isStaff ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        constraints: BoxConstraints(maxWidth: 290.w),
        decoration: BoxDecoration(
          color: isStaff ? AppColors.cardBackground : AppColors.primary,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
            bottomLeft: Radius.circular(isStaff ? 4.r : 16.r),
            bottomRight: Radius.circular(isStaff ? 16.r : 4.r),
          ),
          border: Border.all(
            color: isStaff ? AppColors.border : AppColors.primary,
          ),
        ),
        child: Opacity(
          opacity: isOptimistic ? 0.75 : 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                reply.user?.name ?? (isStaff ? 'Support Team' : 'You'),
                style: AppTextStyles.caption.copyWith(
                  color: metaColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                reply.message,
                style: AppTextStyles.bodyRegular.copyWith(color: textColor),
              ),
              SizedBox(height: 6.h),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    TicketDateFormatter.dateTime(reply.createdAt),
                    style: AppTextStyles.captionSmall.copyWith(
                      color: metaColor,
                    ),
                  ),
                  if (isOptimistic) ...[
                    SizedBox(width: 6.w),
                    Text(
                      'Sending...',
                      style: AppTextStyles.captionSmall.copyWith(
                        color: metaColor,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TicketReplyComposer extends StatelessWidget {
  final TextEditingController controller;
  final bool isClosed;
  final bool isSending;
  final VoidCallback onSend;

  const TicketReplyComposer({
    super.key,
    required this.controller,
    required this.isClosed,
    required this.isSending,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    if (isClosed) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: const BoxDecoration(
          color: AppColors.white,
          border: Border(top: BorderSide(color: AppColors.border)),
        ),
        child: Text(
          'This ticket is closed. Please create a new ticket if you need more help.',
          style: AppTextStyles.bodyRegular,
          textAlign: TextAlign.center,
        ),
      );
    }

    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              minLines: 1,
              maxLines: 4,
              textInputAction: TextInputAction.newline,
              decoration: InputDecoration(
                hintText: 'Write your reply...',
                filled: true,
                fillColor: AppColors.textFieldFillColor,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 14.w,
                  vertical: 10.h,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(width: 10.w),
          SizedBox(
            width: 92.w,
            child: CustomButton(
              text: 'Send',
              isLoading: isSending,
              onPressed: onSend,
              borderRadius: 16,
            ),
          ),
        ],
      ),
    );
  }
}

abstract class TicketDateFormatter {
  static String dateOnly(String input) {
    final date = DateTime.tryParse(input);
    if (date == null) {
      return input.split('T').first;
    }
    return DateFormat('dd MMM yyyy').format(date.toLocal());
  }

  static String dateTime(String input) {
    final date = DateTime.tryParse(input);
    if (date == null) {
      return input;
    }
    return DateFormat('dd MMM, hh:mm a').format(date.toLocal());
  }
}
