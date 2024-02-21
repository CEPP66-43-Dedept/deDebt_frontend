// ignore_for_file: unused_import, unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dedebt_application/repositories/userRepository.dart';
import 'package:dedebt_application/services/userService.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  late final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late final UserRepository userRepository =
      UserRepository(firestore: firestore);
  late final UserService _userService =
      UserService(userRepository: userRepository);
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _userFuture = _getDataHome();
  }

  Future<Map<String, dynamic>?> _getUserData(String userId) async {
    return _userService.getUserData(userId);
  }

  Future<Map<String, dynamic>?> _getUserActiveRequest(String userId) async {
    return _userService.getUserActiveRequest(userId);
  }

  Future<List<dynamic>> _getDataHome() async {
    final results = await Future.wait(
        [_getUserData(user!.uid), _getUserActiveRequest(user!.uid)]);
    return results;
  }

  void createAppointmentContainer(Request uRequest) {
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
            return const Center(child: Text('No User'));
          } else {
            Users _thisuser = Users.fromMap(snapshot.data[0]);
            Request _request = Request.fromMap(snapshot.data[1]);
            //  print(_thisuser.email + _request.advisorId);
            return Scaffold(
              body: Align(
                alignment: Alignment.center,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 25, 10, 0),
                        child: Text(
                          "สวัสดี ${_thisuser.firstname}",
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
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
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
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
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
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  padding: const EdgeInsets
                                                      .symmetric(
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
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  padding: const EdgeInsets
                                                      .symmetric(
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
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  padding: const EdgeInsets
                                                      .symmetric(
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
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  padding: const EdgeInsets
                                                      .symmetric(
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
