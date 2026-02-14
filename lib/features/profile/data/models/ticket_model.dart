enum TicketStatus { inProgress, closed }

class TicketModel {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final TicketStatus status;

  TicketModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.status,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      date: json['date'] != null
          ? DateTime.parse(json['date'] as String)
          : DateTime.now(),
      status: (json['status'] as String?) == 'closed'
          ? TicketStatus.closed
          : TicketStatus.inProgress,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
      'status': status == TicketStatus.closed ? 'closed' : 'in_progress',
    };
  }

  static List<TicketModel> mockTickets = [
    TicketModel(
      id: "#123456",
      title: "Order Issue",
      description:
          "I received the wrong item in my order. Need assistance with...",
      date: DateTime(2026, 1, 5, 14, 30),
      status: TicketStatus.inProgress,
    ),
    TicketModel(
      id: "#123455",
      title: "Delivery Problem",
      description: "Package delivery was delayed by 3 days. Tracking shows...",
      date: DateTime(2026, 1, 4, 11, 45),
      status: TicketStatus.closed,
    ),
    TicketModel(
      id: "#123454",
      title: "Quality Complaint",
      description:
          "Product quality is not as described. Item has manufacturir...",
      date: DateTime(2026, 1, 3, 16, 15),
      status: TicketStatus.closed,
    ),
  ];
}
