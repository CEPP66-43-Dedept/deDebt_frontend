class Timeslot {
  final int tid;
  final DateTime startTime;
  final DateTime endTime;
  final int user_id;
  final int advisor_id;

  Timeslot({
    required this.tid,
    required this.startTime,
    required this.endTime,
    required this.user_id,
    required this.advisor_id,
  });
  Map<String, dynamic> toMap() {
    return {
      'tid': tid,
      'startTime': startTime,
      'endTime': endTime,
      'user_id': user_id,
      'advisor_id': advisor_id,
    };
  }
}
