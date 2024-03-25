import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dedebt_application/models/advisorModel.dart';
import 'package:dedebt_application/repositories/advisorRepository.dart';
import 'package:dedebt_application/repositories/userRepository.dart';
import 'package:dedebt_application/routes/route.dart';
import 'package:dedebt_application/services/advisorService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dedebt_application/models/userModel.dart';
import 'package:dedebt_application/models/assignmentModel.dart';
import 'package:dedebt_application/screens/layouts/advisorLayout.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class homeAdvisorScreen extends StatefulWidget {
  const homeAdvisorScreen({super.key});
  @override
  State<homeAdvisorScreen> createState() => _homeAdvisorScreen();
}

class _homeAdvisorScreen extends State<homeAdvisorScreen> {
  late final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late final AdvisorRepository _advisorRepository =
      AdvisorRepository(firestore: firestore);
  late final AdvisorService _advisorService =
      AdvisorService(advisorRepository: _advisorRepository);
  User? user = FirebaseAuth.instance.currentUser;

  late StreamController<Advisors> _advisorDataController;
  late StreamController<Map<String, dynamic>?> _advisorRequestController;

  final EasyInfiniteDateTimelineController _controller =
      EasyInfiniteDateTimelineController();
  DateTime? _focusDate = DateTime.now();
  //Mockup Data
  Advisors thisAdvisor = Advisors(
    ssn: "",
    firstname: "",
    lastname: "",
    uid: "",
    password: "",
    specialist: "",
    email: "",
    tel: "",
  );
  Assignment userAppointment = Assignment(
    id: "0",
    type: 1,
    title: "การนัดคุยทางโทรศัพท์",
    detail: "โทรทางมือถือเบอร์ 123-456-7890",
    status: 0,
    taskId: "TSETTaskID",
    startTime: Timestamp.fromDate(DateTime(2023, 2, 27, 13, 0)),
    endTime: Timestamp.fromDate(DateTime(2023, 2, 27, 17, 0)),
  );

  Future<void> _getAdvisorData(String userId) async {
    Advisors? advisorData = await _advisorService.getAdvisorData(userId);

    if (advisorData != null) {
      setState(() {
        thisAdvisor = advisorData; // กำหนดค่า thisAdvisor เมื่อมีข้อมูล
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _advisorDataController = StreamController<Advisors>();
    _getAdvisorData(user!.uid);
  }

  @override
  Widget build(BuildContext context) {
    var u_assignment = [userAppointment, userAppointment, userAppointment];
    ScrollController _todaylistviewcontroller = ScrollController();
    ScrollController _monthlistviewcontroller = ScrollController();
    List<Widget> todayAssignmentContainerList = [
      const SizedBox(height: 5),
    ];
    List<Widget> AssignmentMonthContainerList = [
      const SizedBox(height: 5),
    ];

    for (Assignment assign in u_assignment) {
      Widget container =
          AdvisorLayout.createAssignmentContainer(context, assign);
      todayAssignmentContainerList.add(container);
      todayAssignmentContainerList.add(const SizedBox(height: 10));
    }
    for (Assignment assign in u_assignment) {
      Widget container = AdvisorLayout.createMonthAssignmentContainer(
          context, assign, AppRoutes.REQUEST_ADVISOR);
      AssignmentMonthContainerList.add(container);
      AssignmentMonthContainerList.add(const SizedBox(height: 10));
    }
    return StreamBuilder<Advisors>(
        stream: _advisorDataController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('เกิดข้อผิดพลาดในการโหลดข้อมูล'),
            );
          }
          if (snapshot.hasData) {
            thisAdvisor = snapshot.data!;
          }
          return Scaffold(
            body: Align(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 25, 10, 0),
                    child: Text(
                      "สวัสดี ${thisAdvisor.firstname}",
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        "งานของคุณวันนี้",
                        style: TextStyle(fontSize: 24),
                      )),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 14),
                    child: RawScrollbar(
                      controller: _todaylistviewcontroller,
                      thumbColor: const Color(0xFFBBB9F4),
                      thumbVisibility: true,
                      radius: const Radius.circular(20),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6.0, vertical: 10),
                      thickness: 5,
                      child: Container(
                        height: 218,
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
                          child: ListView.builder(
                            controller: _todaylistviewcontroller,
                            itemCount: todayAssignmentContainerList.length,
                            itemBuilder: (context, index) {
                              return todayAssignmentContainerList[index];
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 324,
                    height: 332,
                    margin: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              child: Text("งานในเดือน",
                                  style: TextStyle(
                                    fontSize: 24,
                                  )),
                            ),
                          ],
                        ),
                        Container(
                          width: 272,
                          height: 116,
                          child: EasyDateTimeLine(
                            initialDate: DateTime.now(),
                            dayProps: EasyDayProps(
                              height: 60.0,
                              // must specify the width
                              width: 50.0,
                              dayStructure: DayStructure.dayStrDayNum,
                              activeDayStyle: DayStyle(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                  border: Border.all(
                                    width: 2.0,
                                    color: Colors.grey,
                                  ),
                                  color: const Color(0x7F2DC09C),
                                ),
                              ),
                              inactiveDayStyle: DayStyle(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  border: Border.all(
                                      width: 2.0, color: Colors.grey),
                                ),
                              ),
                            ),
                            headerProps: const EasyHeaderProps(
                              monthPickerType: MonthPickerType.dropDown,
                              dateFormatter: DateFormatter.fullDateDMY(),
                            ),
                            locale: "th",
                            onDateChange: (selectedDate) {
                              setState(() {
                                //คลิปเปลี่ยนวัน
                                _focusDate = selectedDate;
                              });
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: 156,
                          width: 324,
                          //   color: Colors.blue,
                          child: DefaultTextStyle(
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: const Color(0xFF36338C),
                                  fontSize: 15.0,
                                ),
                            child: RawScrollbar(
                                controller: _monthlistviewcontroller,
                                thumbColor: const Color(0xFFBBB9F4),
                                thumbVisibility: true,
                                radius: const Radius.circular(20),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6.0, vertical: 10),
                                child: ListView.builder(
                                    controller: _monthlistviewcontroller,
                                    itemCount:
                                        AssignmentMonthContainerList.length,
                                    itemBuilder: (context, index) {
                                      return AssignmentMonthContainerList[
                                          index];
                                    })),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
