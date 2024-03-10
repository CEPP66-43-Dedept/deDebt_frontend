class Request {
  String id;
  String title;
  String detail;
  String userId;
  String userFullName;
  String advisorId;
  String advisorFullName;
  int requestStatus;
  List<String> type;
  List<int> debtStatus;
  List<String> provider;
  List<String> branch;
  List<int> revenue;
  List<int> expense;
  int burden;
  int property;
  List<int> appointmentDate;

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
    required this.property,
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
      property: map['property'] ?? 0,
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
      'branch': branch,
      'property': property,
      'appointmentDate': appointmentDate,
    };
  }
}
