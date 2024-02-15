class request {
  final int id;
  final String title;
  final String detail;
  final int userId;
  final int advisorId;
  final String requestStatus;
  final List<String> type; //ประเภทของหนี้
  final List<String> debtStatus;
  final List<String> provider;
  final List<int> revenue;
  final List<int> expense;
  final String burden; //ภาระของหนี้ต่อรายรับ
  final int propoty;
  final List<int> assignmentId;
  final List<DateTime> appointmentDate;
  final List<String> appointmentStatus;
  request({
    required this.id,
    required this.title,
    required this.detail,
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
    required this.appointmentStatus,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'detail': detail,
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
      'appointmentDate': appointmentDate,
      'appointmentStatus': appointmentStatus
    };
  }
}
