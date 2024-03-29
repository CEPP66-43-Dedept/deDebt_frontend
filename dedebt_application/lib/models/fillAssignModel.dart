import 'package:cloud_firestore/cloud_firestore.dart';

class FillAssignment {
  String? id;
  List<dynamic> data;
  FillAssignment({
    this.id,
    this.data = const [],
  });

  factory FillAssignment.fromMap(Map<String, dynamic> map) {
    return FillAssignment(
      id: map['id'] ?? '',
      data: map['data'] ?? [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'data': data,
    };
  }
}
