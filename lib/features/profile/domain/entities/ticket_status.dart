enum TicketStatus { open, inProgress, waitingCustomer, resolved, closed }

extension TicketStatusX on TicketStatus {
  String get apiValue {
    switch (this) {
      case TicketStatus.open:
        return 'open';
      case TicketStatus.inProgress:
        return 'in_progress';
      case TicketStatus.waitingCustomer:
        return 'waiting_customer';
      case TicketStatus.resolved:
        return 'resolved';
      case TicketStatus.closed:
        return 'closed';
    }
  }

  String get fallbackLabel => apiValue.replaceAll('_', ' ').toUpperCase();
}
