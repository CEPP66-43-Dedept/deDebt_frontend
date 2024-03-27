import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:dedebt_application/routes/route.dart';
import 'package:dedebt_application/models/requestModel.dart';
import 'package:dedebt_application/models/assignmentModel.dart';
import 'package:dedebt_application/services/authService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdvisorLayout extends StatefulWidget {
  int currentPage = 0;
  final Widget body;
  AdvisorLayout({super.key, required this.body, required this.currentPage});
  static Container getRequestStatusContainer(Request _request) {
    Color containerColor;
    bool isCase1 = false;

    switch (_request.requestStatus) {
      case 0:
        //จัดหาที่ปรึกษา
        containerColor = const Color(0xFFE1E4F8);
        isCase1 = true;
        break;
      case 1:
        //กำลังปรึกษา
        containerColor = const Color(0xFFF18F80);
        break;
      case 2:
        //เสร็จสิ้น
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
        //request status ต้องแก้ไข
        _request.requestStatus == 0
            ? "จัดหาที่ปรึกษา"
            : _request.requestStatus == 1
                ? "กำลังปรึกษา"
                : _request.requestStatus == 1
                    ? "เสร็จสิ้น"
                    : "",

        style: TextStyle(color: isCase1 ? const Color(0xFF7673D3) : null),
      ),
    );
    return statusContainer;
  }

  static GestureDetector createRequestBox(
      BuildContext context, Request _request) {
    return GestureDetector(
      onTap: () {
        context.go(AppRoutes.REQUEST_ADVISOR + '/${_request.id}');
      },
      child: Container(
        width: 324,
        decoration: BoxDecoration(
          color: const Color(0xFF36338C),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                  //สถานะ container
                  getRequestStatusContainer(_request),
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
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        //แก้ดึงข้อมูลชื่อ User
                        _request.userFullName,
                        style: const TextStyle(color: Color(0xFF2DC09C)),
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
                      _request.type.join(","),
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
                      _request.detail,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ]),
      ),
    );
  }

  static GestureDetector createAssignmentContainer(
      BuildContext context, Assignment _assignment) {
    return GestureDetector(
      onTap: () => {
        context.go(AppRoutes.ASSIGNMENT_ADVISOR + '/${_assignment.id}')
        //handle redirect ไปหน้าassignment
      },
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
                  Text(
                    _assignment.title,
                    style: TextStyle(fontSize: 20.0),
                  ),
                  Text(
                    //assignment type อาจจะต้องแก้ไข
                    _assignment.type == 1
                        //เพิ่มวันที่
                        ? "${_assignment.detail} "
                        : _assignment.detail,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      const Text(
                        "สถานะ : ",
                      ),
                      getAssignmentStatusContainer(_assignment)
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Container getAssignmentStatusContainer(Assignment _assignment) {
    var containerColor;
    var textColor;

    switch (_assignment.status) {
      case 0:
        //เสร็จสิ้น
        containerColor = const Color(0xFF2DC09C);
        textColor = const Color(0xFFFAFEFF);
        break;
      case 1:
        //ดำเนินการ
        containerColor = const Color(0xFFE1E4F8);
        textColor = const Color(0xFF7673D3);
        break;
      case 2:
        //ยกเลิก
        containerColor = const Color(0xFFF18F80);
        textColor = const Color(0xFFF0E6EC);
        break;
    }
    return Container(
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Text(
        _assignment.status == 0
            ? "เสร็จสิ้น"
            : _assignment.status == 1
                ? "ดำเนินการ"
                : _assignment.status == 1
                    ? "ยกเลิก"
                    : "",
        style: TextStyle(color: textColor),
      ),
    );
  }

  static GestureDetector createMonthAssignmentContainer(
      BuildContext context, Assignment _assignment, String destination) {
    return GestureDetector(
      onTap: () => {
        context.go(destination)
        //handle redirect ไปหน้าassignment
      },
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
                  Text(
                    _assignment.title,
                    style: const TextStyle(fontSize: 20.0),
                  ),
                  Text(
                    //assignment type อาจจะต้องแก้ไข
                    _assignment.type == "การนัดหมาย"
                        ? "${_assignment.detail} "
                        : _assignment.detail,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      const Text(
                        "เวลา : ",
                      ),
                      Container(
                          width: 100,
                          height: 22,
                          decoration: BoxDecoration(
                            color: const Color(0xFF36338C),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              "${DateFormat("HH:mm").format(_assignment.startTime.toDate())} : ${DateFormat("HH:mm").format(_assignment.endTime.toDate())}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  State<AdvisorLayout> createState() => _AdvisorLayoutState();
}

class _AdvisorLayoutState extends State<AdvisorLayout> {
  static Color primaryColor = const Color(0xFFF3F5FE);
  final Color navbarcolor = const Color(0xFF444371);

  final List<IconData> _normalIcon = [
    Icons.home,
    Icons.attach_money,
    Icons.replay,
    Icons.person
  ];
  final List<IconData> _outlinedIcon = [
    Icons.home_outlined,
    Icons.attach_money_outlined,
    Icons.replay_outlined,
    Icons.person_outline
  ];

  IconData getIcon(int index) {
    return widget.currentPage == index
        ? _normalIcon[index]
        : _outlinedIcon[index];
  }

  Color getIconColors(int index) {
    return widget.currentPage == index ? Colors.white : Colors.grey;
  }

  void onTap(int page) {
    switch (page) {
      case 0:
        if (widget.currentPage != 0) {
          context.go(AppRoutes.HOME_ADVISOR);
        }
        break;
      case 1:
        if (widget.currentPage != 1) {
          context.go(AppRoutes.REQUEST_LIST_ADVISOR);
        }
        break;
      case 2:
        if (widget.currentPage != 2) {
          context.go(AppRoutes.HISTORY_ADVISOR);
        }
        break;
      case 3:
        if (widget.currentPage != 3) {
          context.go(AppRoutes.PROFILE_ADVISOR);
        }
        break;
    }
    setState(() {
      widget.currentPage = page;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> signOut() async {
    try {
      await Auth().signOut();
      setState(() {
        // Set current page to zero or whatever initial page you prefer
        widget.currentPage = 0;
      });
    } on FirebaseAuthException {}
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          surfaceTintColor: Colors.transparent,
          toolbarHeight: 55,
          title: Column(
            children: [
              Container(
                  constraints: const BoxConstraints(
                    maxHeight: 50,
                    maxWidth: double.infinity,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/images/Logo.png',
                          fit: BoxFit.contain,
                        ),
                        IconButton(
                          icon: Icon(Icons.exit_to_app),
                          onPressed: () {
                            signOut();
                          },
                        )
                      ],
                    ),
                  )),
            ],
          ),
        ),
        body: widget.body,
        bottomNavigationBar: SizedBox(
            height: 55,
            child: BottomAppBar(
              color: navbarcolor,
              padding: const EdgeInsets.all(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: Icon(getIcon(0), size: 35, color: getIconColors(0)),
                    onPressed: () {
                      onTap(0);
                    },
                  ),
                  IconButton(
                    icon: Icon(getIcon(1), size: 35, color: getIconColors(1)),
                    onPressed: () {
                      onTap(1);
                    },
                  ),
                  IconButton(
                    icon: Icon(getIcon(2), size: 35, color: getIconColors(2)),
                    onPressed: () {
                      onTap(2);
                    },
                  ),
                  IconButton(
                    icon: Icon(getIcon(3), size: 35, color: getIconColors(3)),
                    onPressed: () {
                      onTap(3);
                    },
                  )
                ],
              ),
            )));
  }
}
