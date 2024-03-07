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
  final List<int> debtStatus;
  final List<String> provider;
  final List<String> branch;
  final List<int> revenue;
  final List<int> expense;
  final int burden;
  final int propoty;
  final List<int> appointmentDate;

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
    required this.branch,
    required this.revenue,
    required this.expense,
    required this.burden,
    required this.propoty,
    required this.appointmentDate,
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
      debtStatus: List<int>.from(map['debtStatus'] ?? []),
      provider: List<String>.from(map['provider'] ?? []),
      branch: List<String>.from(map['branch'] ?? []),
      revenue: List<int>.from(map['revenue'] ?? []),
      expense: List<int>.from(map['expense'] ?? []),
      burden: map['burden'] ?? '',
      propoty: map['propoty'] ?? 0,
      appointmentDate: List<int>.from(map['appointmentDate'] ?? []),
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
    };
  }
}
