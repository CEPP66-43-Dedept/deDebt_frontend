// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:dedebt_application/screens/User/assignmentUserScreen.dart';
import 'package:dedebt_application/services/authService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dedebt_application/routes/route.dart';
import 'package:dedebt_application/models/userModel.dart';
import 'package:dedebt_application/models/requestModel.dart';
import 'package:dedebt_application/models/assignmentModel.dart';

import 'package:dedebt_application/routes/route.dart';

class UserLayout extends StatefulWidget {
  final Widget Body;

  int currentPage = 0;
  UserLayout({Key? key, required this.Body, required this.currentPage})
      : super(key: key);
  @override
  State<UserLayout> createState() => _UserLayoutState();

  static Container getRequestStatusContainer(Request _request) {
    Color containerColor;
    bool isCase1 = false;
    switch (_request.requestStatus) {
      case 0:
        containerColor = const Color(0xFFE1E4F8);
        isCase1 = true;
        break;
      case 1:
        containerColor = const Color(0xFFF18F80);
        break;
      case 2:
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
        _request.requestStatus == 0
            ? "จัดหาที่ปรึกษา"
            : _request.requestStatus == 1
                ? "กำลังปรึกษา"
                : _request.requestStatus == 2
                    ? "เสร็จสิ้น"
                    : "",
        style: TextStyle(color: isCase1 ? const Color(0xFF7673D3) : null),
      ),
    );
    return statusContainer;
  }

  static Container createRequestBox(Request _request) {
    return Container(
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
                const Text("ผู้รับผิดชอบ : "),
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F4FD),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      _request.advisorFullName == ""
                          ? "ยังไม่มีผู้รับผิดชอบ"
                          : _request.advisorFullName,
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
    );
  }

  static Container getAssignmentStatusContainer(Assignment _assignment) {
    var containerColor;
    var textColor;

    switch (_assignment.status) {
      case 0:
        containerColor = const Color(0xFF2DC09C);
        textColor = const Color(0xFFFAFEFF);
        break;
      case 1:
        containerColor = const Color(0xFFE1E4F8);
        textColor = const Color(0xFF7673D3);
        break;
      case 2:
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
                : "ยกเลิก",
        style: TextStyle(color: textColor),
      ),
    );
  }

  static GestureDetector createAssignmentContainer(
      BuildContext context, Assignment _assignment) {
    return GestureDetector(
      onTap: () => {
        context.go(AppRoutes.ASSIGNMENT_USER + '/' + _assignment.id!),
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
                  Text(_assignment.type == 0
                      ? "${_assignment.detail} วันที่ ${_assignment.startTime.toDate().day}/${_assignment.startTime.toDate().month}/${_assignment.startTime.toDate().year} เวลา ${_assignment.startTime.toDate().hour}:${_assignment.startTime.toDate().minute}"
                      : "${_assignment.detail} ภายในวันที่ ${_assignment.startTime.toDate().day}/${_assignment.startTime.toDate().month}/${_assignment.startTime.toDate().year} "),
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
}

class _UserLayoutState extends State<UserLayout> {
  static Color primaryColor = const Color(0xFFF3F5FE);
  final Color navbarcolor = const Color(0xFF444371);
  // ignore: unused_field
  late final User? _currentUser;

  final List<IconData> _normalIcon = [
    Icons.home,
    Icons.attach_money,
    Icons.replay,
    Icons.person
  ];
  @override
  void initState() {
    super.initState();
    _currentUser = FirebaseAuth.instance.currentUser;
  }

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

  Future<void> signOut() async {
    try {
      await Auth().signOut();
    } on FirebaseAuthException {}
  }

  @override
  @override
  Widget build(BuildContext context) {
    void onTap(int page) {
      switch (page) {
        case 0:
          if (widget.currentPage != 0) {
            context.go(AppRoutes.HOME_USER);
          }
          break;
        case 1:
          if (widget.currentPage != 1) {
            context.go(AppRoutes.REQUEST_USER);
          }
          break;
        case 2:
          if (widget.currentPage != 2) {
            context.go(AppRoutes.HISTORY_USER);
          }
          break;
        case 3:
          if (widget.currentPage != 3) {
            context.go(AppRoutes.PROFILE_USER);
          }

          break;
      }
      setState(() {
        widget.currentPage = page;
      });
    }

    return Scaffold(
      body: widget.Body,
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
        ),
      ),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
