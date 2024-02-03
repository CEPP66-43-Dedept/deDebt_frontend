class request {
  final int id;
  final String title;
  final int userId;
  final int advisorId;
  final String requestStatus;
  final List<bool> type;
  final List<String> debtStatus;
  final List<String> provider;
  final List<int> revenue;
  final List<int> expense;
  final List<bool> burden;
  final int propoty;
  final List<int> assignmentId;
  final List<int> appointmentDate;
  request({
    required this.id,
    required this.title,
    required this.userId,
    required this.advisorId,
    required this.requestStatus,
    required this.type,
    required this.debtStatus,
    required this.provider,
    required this.revenue,
    required this.expense,
    required this.burden,
    required this.propoty,
    required this.assignmentId,
    required this.appointmentDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'userId': userId,
      'advisorId': advisorId,
      'reqeustStatus': requestStatus,
      'type': type,
      'debtStatus': debtStatus,
      'provider': provider,
      'revenue': revenue,
      'expense': expense,
      'burden': burden,
      'propoty': propoty,
      'assignmentId': assignmentId,
      'appointmentDate': appointmentDate
    };
  }
}
