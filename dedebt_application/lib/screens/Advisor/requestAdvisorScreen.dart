import 'package:flutter/material.dart';
import 'package:dedebt_application/screens/layouts/advisorLayout.dart';
import 'package:dedebt_application/models/userModel.dart';
import 'package:dedebt_application/models/requestModel.dart';
import 'package:dedebt_application/models/assignmentModel.dart';
import 'package:go_router/go_router.dart';
import 'package:dedebt_application/routes/route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class requestAdvisorScreen extends StatefulWidget {
  const requestAdvisorScreen({super.key});

  @override
  State<requestAdvisorScreen> createState() => _requestAdvisorScreen();
}

class _requestAdvisorScreen extends State<requestAdvisorScreen> {
  bool isExpanded = false;
  //Mockup Data
  Users thisAdvisor = Users(
    id: "0",
    ssn: "000000000000",
    firstname: "สมปรึกษา",
    lastname: "ปรึกษาทุกอย่าง",
    role: 1,
    email: "prugsa@mail.com",
    tel: "0123456789",
  );
  final Request _request = Request(
      id: "0",
      title: "การแก้หนี้กับธนาคารกสิกรไทย",
      detail:
          "123456แก้หนี้ที่ค้างคามานานมากมายแก้หนี้ที่ค้างคามานานมากมายแก้หนี้ที่ค้างคามานานมากมาย1234567890แก้หนี้ที่ค้างคามานานมากมายแก้หนี้ที่ค้างคามานานมากมายแก้หนี้ที่ค้างคามานานมากมาย1234567890แก้หนี้ที่ค้างคามานานมากมายแก้หนี้ที่ค้างคามานานมากมายแก้หนี้ที่ค้างคามานานมากมาย1234567890",
      userId: "0",
      advisorId: "1",
      userFullName: "นายเป็นหนี้ หนี่เป็นกอง",
      advisorFullName: "นายสมปอง งอปมส",
      requestStatus: 0,
      type: [
        "หนี้บัตรเครติด",
        "สินเชื่อส่วนบุคคล",
      ], //[หนี้บัตรเครติด,สินเชื่อส่วนบุคคล,หนี้บ้าน,หนี้จำนำรถ,หนี้เช่าซื้อรถ]
      debtStatus: [0],
      provider: ["กสิกร"],
      revenue: [10000],
      expense: [1000000],
      burden:
          0, //ผ่อนหนี้ [1/3ของรายได้,1/3-1/2ของรายได้,1/2-2/3ของรายได้,มากกว่า 2/3 ของรายได้ ]
      property: 25000,
      appointmentDate: [0],
      branch: ["เมย่า"]);
  Assignment userAppointment = Assignment(
    id: "0",
    type: 0,
    title: "การนัดคุยทางโทรศัพท์",
    detail: "โทรทางมือถือเบอร์ 123-456-7890",
    status: 0,
    taskId: "TSETTaskID",
    startTime: Timestamp.fromDate(DateTime(2023, 2, 27, 13, 0)),
    endTime: Timestamp.fromDate(DateTime(2023, 2, 27, 17, 0)),
  );
  Assignment userAssignment = Assignment(
    id: "1",
    type: 1,
    title: "กรอกเอกสาร",
    detail: "กรอกเอกสารหักเงินของกสิกร",
    status: 0,
    taskId: "TSETTaskID",
    startTime: Timestamp.fromDate(DateTime(2023, 2, 26, 13, 0)),
    endTime: Timestamp.fromDate(DateTime(2023, 2, 26, 17, 0)),
  );
  Assignment userAssignment_2 = Assignment(
    id: "1",
    type: 1,
    title: "กรอกเอกสาร",
    detail: "กรอกเอกสารหักเงินของกสิกร",
    status: 0,
    taskId: "TSETTaskID",
    startTime: Timestamp.fromDate(DateTime(2023, 2, 26, 13, 0)),
    endTime: Timestamp.fromDate(DateTime(2023, 2, 26, 17, 0)),
  );
  String getRequestDetailString(Request _request) {
    String returnString = "ขณะนี้เป็นหนี้กับผู้ให้บริการ";
    for (int i = 0; i < _request.provider.length; i++) {
      String debtStatus = "";
      switch (_request.debtStatus[i]) {
        case 0:
          debtStatus = "ปกติหรือค้างชำระไม่เกิน 90 วัน";
          break;
        case 1:
          debtStatus = "Non-performing Loan(NPL)(ค้างชำระไม่เกิน 90 วัน)";
          break;
        case 2:
          debtStatus = "อยู่ระหว่างกระบวนการกฎหมายหรือศาลพิพากษาแล้ว";
          break;
      }
      returnString =
          "$returnString${_request.provider[i]}ที่สาขา${_request.branch[i]}สถานะหนี้ ณ ตอนนี้ $debtStatus,\n";
    }
    returnString += "\n";
    for (int i = 0; i < _request.revenue.length; i++) {
      String revenue = "";

      switch (i) {
        case 0:
          revenue = "รายได้หลักต่อเดือน";
          break;
        case 1:
          revenue = "รายได้เสริม";
          break;
        case 2:
          revenue = "ผลตอบแทนการลงทุน";
          break;
        case 3:
          revenue = "รายได้จากธุรกิจส่วนตัว";
          break;
      }
      returnString = "$returnString $revenue ${_request.revenue[i]} บาท,\n";
    }
    returnString += "\n";
    for (int i = 0; i < _request.expense.length; i++) {
      String expense = "";

      switch (i) {
        case 0:
          expense = "ค่าใช้จ่ายในชีวิตประจำวันต่อเดือน";
          break;
        case 1:
          expense = "ภาระหนี้";
          break;
      }
      returnString = "$returnString $expense ${_request.expense[i]} บาท,\n";
    }
    returnString += "\nสัดส่วนการผ่อนหนี้ต่อรายได้";
    switch (_request.burden) {
      case 0:
        returnString += " : ผ่อนหนี้ 1/3 ของรายได้ต่อเดือน";
        break;
      case 1:
        returnString +=
            " : ผ่อนหนี้มากกว่า 1/3 แต่ยังน้อยกว่า 1/2 ของรายได้ต่อเดือน";
        break;
      case 2:
        returnString +=
            " : ผ่อนหนี้มากกว่า 1/2 รายได้ต่อเดือนแต่น้อยกว่า 2/3 ต่อเดือน";
        break;
      case 3:
        returnString += " : ผ่อนหนี้ 2/3 ของรายได้ต่อเดือน";
        break;
    }
    returnString +=
        "\nทรัพย์สินส่วนตัว ${_request.property} บาท\nรายละเอียดเพิ่มเติม : ${_request.detail}";
    return returnString;
  }

  dynamic getmiddleBody() {
    bool isHavedata = false;

    ScrollController _scrollController = ScrollController();

    var u_assignment = [userAppointment, userAssignment, userAssignment_2];
    List<Widget> AssignmentStatusContainerList = [
      const SizedBox(height: 5),
    ];
    for (Assignment assignment_item in u_assignment) {
      Widget container = AdvisorLayout.createAssignmentContainer(
          context, assignment_item, AppRoutes.ASSIGNMENT_ADVISOR);

      AssignmentStatusContainerList.add(container);
      AssignmentStatusContainerList.add(const SizedBox(height: 5));
    }
    return Container(
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Align(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(90, 25, 10, 0),
                child: Text(
                  "คำร้องปัจจุบัน",
                  style: TextStyle(fontSize: 24),
                ),
              ),
              SizedBox(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF36338C),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: 324,
                  padding: const EdgeInsets.all(16.0),
                  margin: const EdgeInsets.symmetric(vertical: 16.0),
                  child: DefaultTextStyle(
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.white,
                          fontSize: 15.0,
                        ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: SizedBox(
                            width: 310,
                            child: Text(_request.title,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 24)),
                          ),
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                const Text("สถานะ : "),
                                AdvisorLayout.getRequestStatusContainer(
                                    _request),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const Text("เจ้าของคำร้อง : "),
                                Flexible(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF0F4FD),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Text(
                                      _request.userFullName,
                                      style: const TextStyle(
                                          color: Color(0xFF2DC09C)),
                                      softWrap: true,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("ประเภท : "),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _request.type.join(","),
                                        overflow: isExpanded
                                            ? TextOverflow.visible
                                            : TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("รายละเอียด : "),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        getRequestDetailString(_request),
                                        overflow: isExpanded
                                            ? TextOverflow.visible
                                            : TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              visualDensity:
                                  VisualDensity(horizontal: -4, vertical: -4),
                              icon: Icon(
                                isExpanded
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                size: 42,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  isExpanded = !isExpanded;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Text(
                "ประวัติการดำเนิน",
                style: TextStyle(fontSize: 24),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                child: RawScrollbar(
                  thumbColor: const Color(0xFFBBB9F4),
                  thumbVisibility: true,
                  radius: const Radius.circular(20),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6.0, vertical: 10),
                  thickness: 5,
                  child: Container(
                    height: 309,
                    width: 324,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: DefaultTextStyle(
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: const Color(0xFF36338C),
                            fontSize: 15.0,
                          ),
                      child: ListView.builder(
                        itemCount: AssignmentStatusContainerList.length,
                        itemBuilder: (context, index) {
                          return AssignmentStatusContainerList[index];
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Stack(
          children: [
            getmiddleBody(),
            Positioned(
              right: 16,
              bottom: 16,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF444371),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      context.go(AppRoutes.ADD_ASSIGNMENT_ADVISOR);
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(16),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
