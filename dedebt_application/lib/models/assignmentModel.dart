import 'package:cloud_firestore/cloud_firestore.dart';

class Assignment {
  String? id;
  final int type;
  final String title;
  final String detail;
  final int status;
  final String taskId;
  final Timestamp startTime;
  final Timestamp endTime;

  Assignment(
      {this.id,
      required this.type,
      required this.title,
      required this.detail,
      required this.status,
      required this.taskId,
      required this.startTime,
      required this.endTime});

  factory Assignment.fromMap(Map<String, dynamic> map) {
    return Assignment(
      id: map['id'] ?? '',
      type: map['type'] ?? '',
      title: map['title'] ?? '',
      detail: map['detail'] ?? '',
      status: map['status'] ?? '',
      taskId: map['taskId'] ?? '',
      startTime: map['startTime'] ?? DateTime.now(),
      endTime: map['endTime'] ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'title': title,
      'detail': detail,
      'status': status,
      'taskId': taskId,
      'endTime': endTime,
      'startTime': startTime
    };
  }
}
