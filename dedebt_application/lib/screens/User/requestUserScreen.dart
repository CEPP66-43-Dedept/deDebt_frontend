import 'package:flutter/material.dart';
import 'package:dedebt_application/screens/layouts/userLayout.dart';
import 'package:dedebt_application/models/userModel.dart';
import 'package:dedebt_application/models/requestModel.dart';

class requestUserScreen extends StatefulWidget {
  const requestUserScreen({super.key});

  @override
  State<requestUserScreen> createState() => _requestUserScreen();
}

class _requestUserScreen extends State<requestUserScreen> {
  bool isExpanded = false;
  late Future<request?> _userFuture;

  //Mockup Data
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
      title: "การแก้หนี้กับธนาคารกสิกรไทย",
      detail:
          "123456แก้หนี้ที่ค้างคามานานมากมายแก้หนี้ที่ค้างคามานานมากมายแก้หนี้ที่ค้างคามานานมากมาย1234567890แก้หนี้ที่ค้างคามานานมากมายแก้หนี้ที่ค้างคามานานมากมายแก้หนี้ที่ค้างคามานานมากมาย1234567890แก้หนี้ที่ค้างคามานานมากมายแก้หนี้ที่ค้างคามานานมากมายแก้หนี้ที่ค้างคามานานมากมาย1234567890",
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
    _userFuture = getUserRequest();
  }

  Future<Users?> getUser() async {
    //ไม่มี User ใน DB
    //return null;

    //Mockup Data
    return thisuser;
  }

  Future<request?> getUserRequest() async {
    //ไม่มี user request ใน db ,ลบ"//"ออกเพื่อทดสอบ
    //return null;

    //Mockup data
    return userrequest;
  }

  FutureBuilder getmiddleBody() {
    return FutureBuilder(
      future: _userFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error fetching request'));
        } else if (snapshot.data == null) {
          // ไม่มีข้อมูลใน db
          return Stack(
            children: [
              const Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    "คำร้องปัจจุบัน",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/Nothing.png"),
                      const Text("ไม่มีคำร้องที่ดำเนินการอยู่ในขณะนี้ "),
                      const Text("สามารถกดลงทะเบียนคำร้องได้ที่ปุ่ม \‘+\’")
                    ],
                  ),
                ),
              ),
            ],
          );
        } else {
          //รับข้อมูลจาก db สำเร็จ
          var _request = snapshot.data as request;
          ScrollController _scrollController = ScrollController();
          return SingleChildScrollView(
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
                                    UserLayout.getRequestStatusContainer(
                                        _request),
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: const Text(
                                          //เพิ่มชื่อที่ปรึกษา
                                          "นายนนทัช มุกลีมาศ",
                                          style: TextStyle(
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
                                            _request.detail,
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
                                  visualDensity: VisualDensity(
                                      horizontal: -4, vertical: -4),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6.0, vertical: 10),
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
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: const Color(0xFF36338C),
                                    fontSize: 15.0,
                                  ),
                              child: Container(
                                margin:
                                    const EdgeInsets.fromLTRB(19, 10, 19, 0),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFDAEAFA),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "นัดโทรคุยโทรศัพท์",
                                            style: TextStyle(fontSize: 20.0),
                                          ),
                                          const Text(
                                              "การแก้หนี้จากธนาคาร oooooo"),
                                          Row(
                                            children: [
                                              const Text(
                                                "สถานะ : ",
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFF2DC09C),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
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
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: const Color(0xFF36338C),
                                    fontSize: 15.0,
                                  ),
                              child: Container(
                                margin:
                                    const EdgeInsets.fromLTRB(19, 10, 19, 0),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFDAEAFA),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "นัดโทรคุยโทรศัพท์",
                                            style: TextStyle(fontSize: 20.0),
                                          ),
                                          const Text(
                                              "การแก้หนี้จากธนาคาร oooooo"),
                                          Row(
                                            children: [
                                              const Text(
                                                "สถานะ : ",
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFF2DC09C),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
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
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: const Color(0xFF36338C),
                                    fontSize: 15.0,
                                  ),
                              child: Container(
                                margin:
                                    const EdgeInsets.fromLTRB(19, 10, 19, 0),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFDAEAFA),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "นัดโทรคุยโทรศัพท์",
                                            style: TextStyle(fontSize: 20.0),
                                          ),
                                          const Text(
                                              "การแก้หนี้จากธนาคาร oooooo"),
                                          Row(
                                            children: [
                                              const Text(
                                                "สถานะ : ",
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFF2DC09C),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
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
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: const Color(0xFF36338C),
                                    fontSize: 15.0,
                                  ),
                              child: Container(
                                margin:
                                    const EdgeInsets.fromLTRB(19, 10, 19, 0),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFDAEAFA),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "นัดโทรคุยโทรศัพท์",
                                            style: TextStyle(fontSize: 20.0),
                                          ),
                                          const Text(
                                              "การแก้หนี้จากธนาคาร oooooo"),
                                          Row(
                                            children: [
                                              const Text(
                                                "สถานะ : ",
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFF2DC09C),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
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
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Scaffold getBody() {
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
                      // Handle button press
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

  @override
  Widget build(BuildContext context) {
    return UserLayout(
      Body: getBody(),
      currentPage: 1,
    );
  }
}
