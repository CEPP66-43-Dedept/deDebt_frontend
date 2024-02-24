import 'package:cloud_firestore/cloud_firestore.dart';

class Request {
  final String id;
  final String title;
  final String detail;
  final String userId;
  final String advisorId;
  final int requestStatus;
  final List<String> type; //ประเภทของหนี้
  final List<String> debtStatus;
  final List<String> provider;
  final List<int> revenue;
  final List<int> expense;
  final String burden; //ภาระของหนี้ต่อรายรับ
  final int propoty;
  final List<int> appointmentDate;
  final int appointmentStatus;
  Request({
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
    required this.appointmentDate,
    required this.appointmentStatus,
  });
  factory Request.fromMap(Map<String, dynamic> map) {
    return Request(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      detail: map['detail'] ?? '',
      userId: map['userId'] ?? '',
      advisorId: map['advisorId'],
      requestStatus: map['requestStatus'] ?? 0, // fixed typo here
      type: List<String>.from(map['type'] ?? []),
      debtStatus: List<String>.from(map['debtStatus'] ?? []),
      provider: List<String>.from(map['provider'] ?? []),
      revenue: List<int>.from(map['revenue'] ?? []),
      expense: List<int>.from(map['expense'] ?? []),
      burden: map['burden'] ?? '',
      propoty: map['propoty'] ?? '',
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
      'requestStatus': requestStatus,
      'type': type,
      'debtStatus': debtStatus,
      'provider': provider,
      'revenue': revenue,
      'expense': expense,
      'burden': burden,
      'propoty': propoty,
      'appointmentDate': appointmentDate,
      'appointmentStatus': appointmentStatus
    };
  }
}
