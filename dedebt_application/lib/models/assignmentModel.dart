class Assignment {
  final int id;
  final String type;
  final String title;
  final String detail;
  final String status;
  final int tid;
  final List<DateTime> advisorTimeslot;
  final DateTime userTimeslot;

  Assignment(
      {required this.id,
      required this.type,
      required this.title,
      required this.detail,
      required this.status,
      required this.tid,
      required this.advisorTimeslot,
      required this.userTimeslot});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'title': title,
      'detail': detail,
      'status': status,
      'tid': tid,
      'advicorTimeslot': advisorTimeslot,
      'userTimslot': userTimeslot
    };
  }
}
