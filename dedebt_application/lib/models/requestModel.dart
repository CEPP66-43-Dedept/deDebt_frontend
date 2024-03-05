class Request {
  final String id;
  final String title;
  final String detail;
  final String userId;
  final String userFullName;
  final String advisorId;
  final String advisorFullName;
  final int requestStatus;
  final List<String> type;
  final List<String> debtStatus;
  final List<String> provider;
  final List<int> revenue;
  final List<int> expense;
  final int burden;
  final int propoty;
  final List<int> appointmentDate;
  final int appointmentStatus;

  Request({
    required this.id,
    required this.title,
    required this.detail,
    required this.userId,
    required this.advisorId,
    required this.userFullName,
    required this.advisorFullName,
    required this.requestStatus,
    required this.type,
    required this.debtStatus,
    required this.provider,
    required this.revenue,
    required this.expense,
    required this.burden,
    required this.propoty,
    required this.appointmentDate,
    required this.appointmentStatus,
  });

  factory Request.fromMap(Map<String, dynamic> map) {
    return Request(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      detail: map['detail'] ?? '',
      userId: map['userId'] ?? '',
      advisorId: map['advisorId'] ?? '',
      userFullName: map['userFullName'] ?? '',
      advisorFullName: map['advisorFullName'] ?? '',
      requestStatus: map['requestStatus'] ?? 0,
      type: List<String>.from(map['type'] ?? []),
      debtStatus: List<String>.from(map['debtStatus'] ?? []),
      provider: List<String>.from(map['provider'] ?? []),
      revenue: List<int>.from(map['revenue'] ?? []),
      expense: List<int>.from(map['expense'] ?? []),
      burden: map['burden'] ?? 0,
      propoty: map['propoty'] ?? 0,
      appointmentDate: List<int>.from(map['appointmentDate'] ?? []),
      appointmentStatus: map['appointmentStatus'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'detail': detail,
      'userId': userId,
      'advisorId': advisorId,
      'advisorFullName': advisorFullName,
      'requestStatus': requestStatus,
      'type': type,
      'debtStatus': debtStatus,
      'provider': provider,
      'revenue': revenue,
      'expense': expense,
      'burden': burden,
      'propoty': propoty,
      'appointmentDate': appointmentDate,
      'appointmentStatus': appointmentStatus,
    };
  }
}
