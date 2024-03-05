import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dedebt_application/repositories/userRepository.dart';
import 'package:dedebt_application/services/userService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dedebt_application/routes/route.dart';
import 'package:dedebt_application/models/userModel.dart';
import 'package:dedebt_application/models/requestModel.dart';
import 'package:dedebt_application/models/assignmentModel.dart';
import 'package:dedebt_application/screens/layouts/userLayout.dart';
import 'dart:async';

class HomeUserScreen extends StatefulWidget {
  const HomeUserScreen({Key? key}) : super(key: key);

  @override
  State<HomeUserScreen> createState() => _HomeUserScreenState();
}

class _HomeUserScreenState extends State<HomeUserScreen> {
  late final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late final UserRepository userRepository =
      UserRepository(firestore: firestore);
  late final UserService userService =
      UserService(userRepository: userRepository);
  User? user = FirebaseAuth.instance.currentUser;

  late StreamController<Map<String, dynamic>?> _userDataController;
  late StreamController<Map<String, dynamic>?> _userRequestController;

  @override
  void initState() {
    super.initState();
    _userDataController = StreamController<Map<String, dynamic>?>();
    _userRequestController = StreamController<Map<String, dynamic>?>();

    _getUserData(user!.uid).then((userData) {
      _userDataController.add(userData);
    }).catchError((error) {
      _userDataController.addError(error);
    });

    _getUserActiveRequest(user!.uid).then((requestData) {
      _userRequestController.add(requestData);
    }).catchError((error) {
      _userRequestController.addError(error);
    });
  }

  Future<Map<String, dynamic>?> _getUserData(String userId) async {
    return userService.getUserData(userId);
  }

  Future<Map<String, dynamic>?> _getUserActiveRequest(String userId) async {
    return userService.getUserActiveRequest(userId);
  }

  Future<List<Assignment>> _getActiveAssignments(String taskId) async {
    return userService.getActiveAssignments(taskId);
  }

  @override
  void dispose() {
    _userDataController.close();
    _userRequestController.close();
    super.dispose();
  }

  Widget _buildActiveRequest(Request request) {
    return Card(
      child: ListTile(
        title: Text(request.title),
        subtitle: Text(request.detail),
        trailing: Icon(Icons.arrow_forward),
        onTap: () {
          // Handle tap on the active request
        },
      ),
    );
  }

  Widget getBody() {
    return StreamBuilder<Map<String, dynamic>?>(
      stream: _userDataController.stream,
      builder: (context, userDataSnapshot) {
        return StreamBuilder<Map<String, dynamic>?>(
          stream: _userRequestController.stream,
          builder: (context, requestSnapshot) {
            if (userDataSnapshot.connectionState == ConnectionState.waiting ||
                requestSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (userDataSnapshot.hasError || requestSnapshot.hasError) {
              return const Center(child: Text('Error fetching data'));
            } else if (!userDataSnapshot.hasData || !requestSnapshot.hasData) {
              return const Center(child: Text('No Data'));
            } else {
              print(userDataSnapshot.data);
              print(requestSnapshot.data);

              Users _thisuser = Users.fromMap(userDataSnapshot.data!);
              Request _request = Request.fromMap(requestSnapshot.data!);

              return FutureBuilder<List<Assignment>>(
                future: _getActiveAssignments(_request.id),
                builder: (context, assignmentSnapshot) {
                  if (assignmentSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (assignmentSnapshot.hasError) {
                    return const Center(
                        child: Text('Error fetching assignments'));
                  } else {
                    List<Assignment> assignments = assignmentSnapshot.data!;

                    return Scaffold(
                      body: Align(
                        alignment: Alignment.center,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 25, 10, 0),
                                child: Text(
                                  "คำร้องของคุณ",
                                  style: TextStyle(fontSize: 24),
                                ),
                              ),
                              DefaultTextStyle(
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                    ),
                                child: GestureDetector(
                                  onTap: () =>
                                      {context.go(AppRoutes.REQUEST_USER)},
                                  child: UserLayout.createRequestBox(_request),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  "การนัดหมาย",
                                  style: TextStyle(fontSize: 24),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 14),
                                child: RawScrollbar(
                                  thumbColor: const Color(0xFFBBB9F4),
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
                                    // Your assignment list widget here
                                    child: ListView.builder(
                                      itemCount: assignments.length,
                                      itemBuilder: (context, index) {
                                        Assignment assignment =
                                            assignments[index];
                                        // Build UI for each assignment
                                        return UserLayout
                                            .createAssignmentContainer(
                                                context, assignment);
                                      },
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
                },
              );
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return getBody();
  }
}
