import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:laundry/core/di/injection_container.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_bar_factory.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../domain/entities/ticket_entity.dart';
import '../../domain/entities/ticket_status.dart';
import '../cubit/support_cubit.dart';
import '../cubit/support_state.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({super.key});

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  late final SupportCubit _supportCubit;
  Map<String, String> _statusLabelsByValue = const {};

  @override
  void initState() {
    super.initState();
    _supportCubit = getIt<SupportCubit>();
    unawaited(_refreshSupportData());
  }

  @override
  void dispose() {
    _supportCubit.close();
    super.dispose();
  }

  Future<void> _loadStatusLabels() async {
    final statuses = await _supportCubit.loadTicketStatuses();
    if (!mounted) {
      return;
    }

    final statusLabels = {
      for (final option in statuses) option.value: option.label,
    };

    if (mapEquals(_statusLabelsByValue, statusLabels)) {
      return;
    }

    setState(() {
      _statusLabelsByValue = statusLabels;
    });
  }

  Future<void> _refreshSupportData() {
    return Future.wait<void>([
      _supportCubit.loadTickets(),
      _loadStatusLabels(),
    ]);
  }

  Future<void> _openRouteAndRefresh({
    required String routeName,
    Map<String, String>? pathParameters,
  }) async {
    await context.pushNamed(
      routeName,
      pathParameters: pathParameters ?? const {},
    );
    if (!mounted) {
      return;
    }
    await _refreshSupportData();
  }

  String _statusLabelFor(TicketStatus status) {
    final statusValue = status.apiValue;
    return _statusLabelsByValue[statusValue] ?? status.fallbackLabel;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _supportCubit,
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
                      loading:
                          () =>
                              const Center(child: CircularProgressIndicator()),
                      error:
                          (msg) => Center(
                            child: Text(
                              msg,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
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
                          itemBuilder: (_, index) {
                            final ticket = tickets[index];
                            return _TicketCard(
                              ticket: ticket,
                              statusLabel: _statusLabelFor(ticket.status),
                              onTap:
                                  () => _openRouteAndRefresh(
                                    routeName: 'ticketDetails',
                                    pathParameters: {
                                      'ticketId': ticket.id.toString(),
                                    },
                                  ),
                            );
                          },
                        );
                      },
                      orElse: () => const SizedBox.shrink(),
                    );
                  },
                ),
              ),
              SizedBox(height: 16.h),
              CustomButton(
                text: "Open a ticket",
                onPressed: () => _openRouteAndRefresh(routeName: 'newTicket'),
                prefix: const Icon(Icons.add, color: AppColors.white),
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
  final TicketEntity ticket;
  final String statusLabel;
  final VoidCallback onTap;

  const _TicketCard({
    required this.ticket,
    required this.statusLabel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final statusTextColor = ticket.status.statusTextColor;
    final statusBackgroundColor = ticket.status.statusBackgroundColor;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
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
                    color: statusBackgroundColor,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    statusLabel,
                    style: AppTextStyles.caption.copyWith(
                      fontWeight: FontWeight.w600,
                      color: statusTextColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Text(
              ticket.subject,
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
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
                Text(
                  "Priority: ${ticket.priority.toUpperCase()}",
                  style: AppTextStyles.captionSmall,
                ),
                Text(
                  _formatDate(ticket.createdAt),
                  style: AppTextStyles.captionSmall,
                ),
              ],
            ),
          ],
        ),
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

extension TicketStatusUiX on TicketStatus {
  Color get statusTextColor {
    switch (this) {
      case TicketStatus.open:
      case TicketStatus.inProgress:
      case TicketStatus.waitingCustomer:
        return Colors.orange[800]!;
      case TicketStatus.resolved:
        return AppColors.success;
      case TicketStatus.closed:
        return Colors.grey[700]!;
    }
  }

  Color get statusBackgroundColor {
    switch (this) {
      case TicketStatus.open:
      case TicketStatus.inProgress:
      case TicketStatus.waitingCustomer:
        return Colors.orange.withAlpha(50);
      case TicketStatus.resolved:
        return AppColors.success.withAlpha(50);
      case TicketStatus.closed:
        return Colors.grey.withAlpha(40);
    }
  }
}
