import 'package:flutter/material.dart';
import 'package:dedebt_application/models/userModel.dart';
import 'package:dedebt_application/models/requestModel.dart';
import 'package:dedebt_application/screens/layouts/userLayout.dart';

class homeUserScreen extends StatefulWidget {
  const homeUserScreen({super.key});

  @override
  State<homeUserScreen> createState() => _homeUserScreenState();
}

class _homeUserScreenState extends State<homeUserScreen> {
  final ScrollController _scrollController = ScrollController();
  Users thisuser = Users(
    id: 0,
    ssn: 0,
    firstname: "สมชาย",
    lastname: "ชายมาก",
    roles: "ลูกหนี้",
    requests: [0],
    email: "somchai@mail.com",
    tel: "0123456789",
    password: "SecureP@ssw0rd",
  );
  request userrequest = request(
      id: 0,
      title: "การแก้หนี้กับธนาคารกสิกร",
      detail:
          "แก้หนี้ที่ค้างคามานานมากมายแก้หนี้ที่ค้างคามานานมากมายแก้หนี้ที่ค้างคามานานมากมาย",
      userId: 0,
      advisorId: 0,
      requestStatus: "เสร็จสิ้น",
      type: [
        "หนี้บัตรเครติด",
        "สินเชื่อส่วนบุคคล",
      ], //[หนี้บัตรเครติด,สินเชื่อส่วนบุคคล,หนี้บ้าน,หนี้จำนำรถ,หนี้เช่าซื้อรถ]
      debtStatus: ["Normal"],
      provider: ["กสิกร"],
      revenue: [10000],
      expense: [1000000],
      burden:
          "1/3ของรายได้", //ผ่อนหนี้ [1/3ของรายได้,1/3-1/2ของรายได้,1/2-2/3ของรายได้,มากกว่า 2/3 ของรายได้ ]
      propoty: 25000,
      assignmentId: [],
      appointmentDate: [DateTime(2024, 2, 17)],
      appointmentStatus: [
        "เสร็จสิ้น",
      ]);

  @override
  void initState() {
    super.initState();
  }

  Container getStatusContainer(request uRequest) {
    Color containerColor;
    bool isCase1 = false;
    switch (uRequest.requestStatus) {
      case "จัดหาที่ปรึกษา":
        containerColor = const Color(0xFFE1E4F8);
        isCase1 = true;
        break;
      case "กำลังปรึกษา":
        containerColor = const Color(0xFFF18F80);
        break;
      case "เสร็จสิ้น":
        containerColor = const Color(0xFF2DC09C);
        break;
      default:
        containerColor = const Color(0xFFFFFFFF);
        break;
    }
    Container statusContainer = Container(
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Text(
        uRequest.requestStatus,
        style: TextStyle(color: isCase1 ? const Color(0xFF7673D3) : null),
      ),
    );

    return statusContainer;
  }

  void createAppointmentContainer(request uRequest) {
    var list = uRequest.appointmentDate;
    for (int i = 0; i <= list.length; i++) {}
    return;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 25, 10, 0),
              child: Text(
                "สวัสดี ${thisuser.firstname}",
                style: const TextStyle(fontSize: 20),
              ),
            ),
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  "คำร้องของคุณ",
                  style: TextStyle(fontSize: 24),
                )),
            Container(
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
                          child: Text(userrequest.title,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 24)),
                        ),
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              const Text("สถานะ : "),
                              //สถานะ container
                              getStatusContainer(userrequest),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              const Text("ผู้รับผิดชอบ : "),
                              Flexible(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF0F4FD),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: const Text(
                                    "นางสมหญิง หญิงมาก",
                                    style: TextStyle(color: Color(0xFF2DC09C)),
                                    softWrap: true,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              const Text("ประเภท : "),
                              SizedBox(
                                width: 200,
                                child: Text(
                                  userrequest.type.join(","),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              const Text("รายละเอียด : "),
                              SizedBox(
                                width: 200,
                                child: Text(
                                  userrequest.detail,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ]),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "การนัดหมาย",
                style: TextStyle(fontSize: 24),
              ),
            ),
            RawScrollbar(
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
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    DefaultTextStyle(
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: const Color(0xFF36338C),
                            fontSize: 15.0,
                          ),
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(19, 10, 19, 0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFDAEAFA),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "นัดโทรคุยโทรศัพท์",
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                  const Text("การแก้หนี้จากธนาคาร oooooo"),
                                  Row(
                                    children: [
                                      const Text(
                                        "สถานะ : ",
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF2DC09C),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25.0),
                                        child: const Text(
                                          "เสร็จสิ้น",
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    DefaultTextStyle(
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: const Color(0xFF36338C),
                            fontSize: 15.0,
                          ),
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(19, 10, 19, 0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFDAEAFA),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "นัดโทรคุยโทรศัพท์",
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                  const Text("การแก้หนี้จากธนาคาร oooooo"),
                                  Row(
                                    children: [
                                      const Text(
                                        "สถานะ : ",
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF2DC09C),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25.0),
                                        child: const Text(
                                          "เสร็จสิ้น",
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    DefaultTextStyle(
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: const Color(0xFF36338C),
                            fontSize: 15.0,
                          ),
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(19, 10, 19, 0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFDAEAFA),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "นัดโทรคุยโทรศัพท์",
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                  const Text("การแก้หนี้จากธนาคาร oooooo"),
                                  Row(
                                    children: [
                                      const Text(
                                        "สถานะ : ",
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF2DC09C),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25.0),
                                        child: const Text(
                                          "เสร็จสิ้น",
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    DefaultTextStyle(
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: const Color(0xFF36338C),
                            fontSize: 15.0,
                          ),
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(19, 10, 19, 0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFDAEAFA),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "นัดโทรคุยโทรศัพท์",
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                  const Text("การแก้หนี้จากธนาคาร oooooo"),
                                  Row(
                                    children: [
                                      const Text(
                                        "สถานะ : ",
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF2DC09C),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25.0),
                                        child: const Text(
                                          "เสร็จสิ้น",
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
