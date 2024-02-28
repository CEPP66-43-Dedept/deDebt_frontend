import 'package:cloud_firestore/cloud_firestore.dart';

class Assignment {
  final String id;
  final int type;
  final String title;
  final String detail;
  final int status;
  final String taskID;
  final Timestamp startTime;
  final Timestamp endTime;

  Assignment(
      {required this.id,
      required this.type,
      required this.title,
      required this.detail,
      required this.status,
      required this.taskID,
      required this.startTime,
      required this.endTime});

  factory Assignment.fromMap(Map<String, dynamic> map) {
    return Assignment(
      id: map['id'],
      type: map['type'],
      title: map['title'],
      detail: map['detail'],
      status: map['status'],
      taskID: map['taskID'],
      startTime: map['startTime'],
      endTime: map['endTime'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'title': title,
      'detail': detail,
      'status': status,
      'taskID': taskID,
      'endTime': endTime,
      'startTime': startTime
    };
  }
}