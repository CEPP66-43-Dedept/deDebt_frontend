class request {
  final int id;
  final String title;
  final int userId;
  final int advisorId;
  final String requestStatus;
  final List<int> type;
  /* 0 -> บัตรเครดิต
  1 -> สินเชื่อส่วนบุคคล หรือบัตรกดเงินสด
  2 -> หนี้บ้าน หนี้ที่อยู่อาศัย หนี้บ้านแลกเงิน
  3 -> หนี้จำนำทะเบียนรถ
  4 -> หนี้เช่าซื้อรถ
  */
  final List<String> debtStatus;
  final List<String> provider;
  final List<int> revenue;
  final List<int> expense;
  final List<int> burden;
  /*
  0 -> ปกติหรือค้างชำระไม่เกิน 90 วัน
  1 -> Non-performing Loan (NPL) (ค้างชำระเกิน 90 วัน)
  2 -> อยู่ระหว่างกระบวนการกฎหมายหรือศาลพิพากษาแล้ว
  */
  final int propoty;
  final List<int> assignmentId;
  final List<int> appointmentDate;
  request({
    required this.id,
    required this.title,
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
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
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
      'appointmentDate': appointmentDate
    };
  }
}
