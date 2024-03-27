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

  late StreamController<List<Assignment>?> _assignmentTodayController;
  late StreamController<List<Assignment>?> _assignmentThisdayController;

  final EasyInfiniteDateTimelineController _controller =
      EasyInfiniteDateTimelineController();
  DateTime? _focusDate = DateTime.now();

  //Mockup Data
  List<Assignment>? assignmentTodayData = [];
  List<Assignment>? assignmentThisdayData = [];
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

  Future<List<Assignment>?> _getAssignmentByDay(
      Timestamp day, String advisorId) async {
    try {
      return await _advisorService.getAssignmentByDay(day, advisorId);
    } catch (e) {
      print('Error getting assignment data: $e');
      return null;
    }
  }

  Future<void> _getAdvisorData(String userId) async {
    Advisors? advisorData = await _advisorService.getAdvisorData(userId);

    if (advisorData != null) {
      setState(() {
        thisAdvisor = advisorData;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _advisorDataController = StreamController<Advisors>();
    _getAdvisorData(user!.uid);
    _assignmentTodayController = StreamController<List<Assignment>?>();
    _getAssignmentByDay(Timestamp.now(), user!.uid).then((assignmentData) {
      _assignmentTodayController.add(assignmentData);
      if (assignmentData != null) {
        setState(() {
          assignmentTodayData = assignmentData;
        });
      }
    }).catchError((error) {
      _assignmentTodayController.addError(error);
    });
    _assignmentThisdayController = StreamController<List<Assignment>?>();
    _getAssignmentByDay(Timestamp.now(), user!.uid).then((assignmentData) {
      _assignmentThisdayController.add(assignmentData);
      if (assignmentData != null) {
        setState(() {
          assignmentThisdayData = assignmentData;
        });
      }
    }).catchError((error) {
      _assignmentTodayController.addError(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    var u_assignment = [];
    ScrollController _todaylistviewcontroller = ScrollController();
    ScrollController _monthlistviewcontroller = ScrollController();
    List<Widget> todayAssignmentContainerList = [
      const SizedBox(height: 5),
    ];
    List<Widget> AssignmentMonthContainerList = [
      const SizedBox(height: 5),
    ];

    for (Assignment assign in assignmentTodayData!) {
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

          return StreamBuilder<List<Assignment>?>(
              stream: _assignmentTodayController.stream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('เกิดข้อผิดพลาดในการโหลดข้อมูล'),
                  );
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
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: const Color(0xFF36338C),
                                      fontSize: 15.0,
                                    ),
                                child: ListView.builder(
                                  controller: _todaylistviewcontroller,
                                  itemCount:
                                      todayAssignmentContainerList.length,
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
                                  onDateChange: (selectedDate) {
                                    setState(() {
                                      _focusDate = selectedDate;
                                    });
                                    _getAssignmentByDay(
                                            Timestamp.fromDate(selectedDate),
                                            user!.uid)
                                        .then((assignmentData) {
                                      setState(() {
                                        assignmentThisdayData =
                                            assignmentData ?? [];
                                      });
                                    }).catchError((error) {
                                      print(
                                          'Error getting assignment data: $error');
                                    });
                                  },

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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
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
                                  // onDateChange: (selectedDate) {
                                  //   setState(() {
                                  //     //คลิปเปลี่ยนวัน
                                  //     _focusDate = selectedDate;
                                  //   });
                                  // },
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
                                              assignmentThisdayData!.length,
                                          itemBuilder: (context, index) {
                                            return AdvisorLayout
                                                .createMonthAssignmentContainer(
                                                    context,
                                                    assignmentThisdayData![
                                                        index],
                                                    AppRoutes.REQUEST_ADVISOR +
                                                        '/' +
                                                        assignmentThisdayData![
                                                                index]
                                                            .taskId);
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
        });
  }
}
