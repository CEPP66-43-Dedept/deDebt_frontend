// ignore_for_file: unused_import, unused_field

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
  late Future<dynamic> _userFuture;

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
    _userFuture = getDataHome();
  }

  Future<List<dynamic>> getDataHome() async {
    final results = await Future.wait([getUser(), getUserRequest()]);
    return results;
  }

  Future<Users?> getUser() async {
    //ไม่มี User ใน DB
    //return null;

    //Mockup Data
    return thisuser;
  }

  Future<request?> getUserRequest() async {
    //ไม่มี user request ใน db
    //return null;

    //Mockup data
    return userrequest;
  }

  void createAppointmentContainer(request uRequest) {
    //leave ทิ้งว่างเพราะว่ายังไม่มี Appointment model
    var list = uRequest.appointmentDate;
    for (int i = 0; i <= list.length; i++) {}
    return;
  }

  FutureBuilder getBody() {
    return FutureBuilder(
        future: _userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching request'));
          } else if (snapshot.data == null) {
            // ไม่มีข้อมูลใน db
            return const Center(child: Text('No User'));
          } else {
            var thisuser = snapshot.data[0] as Users;
            var _request = snapshot.data[1] as request;

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
                    DefaultTextStyle(
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.white,
                              fontSize: 15.0,
                            ),
                        child: UserLayout.createRequestBox(_request)),
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
                        child: DefaultTextStyle(
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: const Color(0xFF36338C),
                                    fontSize: 15.0,
                                  ),
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              Container(
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
                              Container(
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
                              Container(
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
                              Container(
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
        });
  }

  @override
  Widget build(BuildContext context) {
    return getBody();
  }
}
