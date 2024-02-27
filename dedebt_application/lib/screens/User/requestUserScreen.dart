import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dedebt_application/models/advisorModel.dart';
import 'package:dedebt_application/repositories/userRepository.dart';
import 'package:dedebt_application/services/userService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dedebt_application/screens/layouts/userLayout.dart';
import 'package:dedebt_application/models/userModel.dart';
import 'package:dedebt_application/models/requestModel.dart';
import 'package:dedebt_application/models/assignmentModel.dart';
import 'package:go_router/go_router.dart';
import 'package:dedebt_application/routes/route.dart';

class requestUserScreen extends StatefulWidget {
  const requestUserScreen({super.key});

  @override
  State<requestUserScreen> createState() => _requestUserScreen();
}

class _requestUserScreen extends State<requestUserScreen> {
  late final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late final UserRepository userRepository =
      UserRepository(firestore: firestore);
  late final UserService userService =
      UserService(userRepository: userRepository);
  late StreamController<Map<String, dynamic>?> _userRequestController;
  late User? user = FirebaseAuth.instance.currentUser;

  bool isExpanded = false;

  //Mockup Data

  @override
  void initState() {
    super.initState();
    _userRequestController = StreamController<Map<String, dynamic>?>();
    _getUserActiveRequest(user!.uid).then((requestData) {
      _userRequestController.add(requestData);
    }).catchError((error) {
      _userRequestController.addError(error);
    });
  }

  @override
  void dispose() {
    _userRequestController.close();
    super.dispose();
  }

  Future<Map<String, dynamic>?> _getUserActiveRequest(String userId) async {
    return userService.getUserActiveRequest(userId);
  }

  dynamic getmiddleBody() {
    bool isHavedata = false;
    if (isHavedata) {
    } else {
      ScrollController _scrollController = ScrollController();

      var u_assignment = [];
      List<Widget> AssignmentStatusContainerList = [
        const SizedBox(height: 5),
      ];
      for (Assignment assignment_item in u_assignment) {
        Widget container =
            UserLayout.createAssignmentContainer(context, assignment_item);

        AssignmentStatusContainerList.add(container);
        AssignmentStatusContainerList.add(const SizedBox(height: 5));
      }
      return StreamBuilder<Map<String, dynamic>?>(
          stream: _userRequestController.stream,
          builder: (context, requestSnapshot) {
            if (requestSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (requestSnapshot.hasError) {
              return const Center(child: Text('Error fetching data'));
            } else if (!requestSnapshot.hasData) {
              return const Center(child: Text('No Data'));
            }
            print(requestSnapshot.data);
            Request userrequest = Request.fromMap(requestSnapshot.data!);
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
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
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
                                        UserLayout.getRequestStatusContainer(
                                            userrequest),
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
                                            child: Text(
                                              userrequest.advisorFullName,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text("ประเภท : "),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                userrequest.type.join(","),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text("รายละเอียด : "),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                userrequest.detail,
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
                            child: DefaultTextStyle(
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
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
          });
    }
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
                      context.go(AppRoutes.SEND_REQUEST_USER);
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
