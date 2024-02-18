// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dedebt_application/repositories/adminRepository.dart';
import 'package:dedebt_application/services/adminService.dart';
import 'package:dedebt_application/variables/color.dart';
import 'package:dedebt_application/widgets/createAdvisorBottomsheet.dart';
import 'package:dedebt_application/widgets/userList.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  int currentIndex = 1;
  late final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late final AdminRepository adminRepository =
      AdminRepository(firestore: firestore);
  late final AdminService adminService =
      AdminService(adminRepository: adminRepository);
  final StreamController<List<Map<String, dynamic>>> userController =
      StreamController();

  @override
  void initState() {
    super.initState();
    loadUsersData(currentIndex);
  }

  @override
  void dispose() {
    userController.close();
    super.dispose();
  }

  Future<void> loadUsersData(int currIndex) async {
    try {
      final List<Map<String, dynamic>> newData =
          await adminService.getAllUsersData(currIndex);
      userController.add(newData);
    } catch (e) {
      print('Error loading users data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: userController.stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final List<Map<String, dynamic>> usersData = snapshot.data ?? [];
          return Scaffold(
            backgroundColor: const Color(0xFFF2F5FF),
            body: Stack(
              children: [
                Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        "จัดการผู้ใช้",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      ToggleSwitch(
                        fontSize: 20,
                        minWidth: 150.0,
                        cornerRadius: 20.0,
                        activeBgColors: const [
                          [ColorGuide.blueAccent],
                          [ColorGuide.blueAccent]
                        ],
                        activeFgColor: ColorGuide.blueLight,
                        inactiveBgColor: ColorGuide.whiteAccent,
                        inactiveFgColor: ColorGuide.blueAccent,
                        initialLabelIndex: currentIndex,
                        totalSwitches: 2,
                        labels: const ['ที่ปรึกษา', 'ผู้ใช้งาน'],
                        radiusStyle: true,
                        onToggle: (index) {
                          setState(() {
                            currentIndex = index!;
                          });
                          loadUsersData(currentIndex);
                        },
                      ),
                      Container(
                        width: 350,
                        height: 500,
                        decoration: BoxDecoration(
                          color: ColorGuide.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 199, 198, 255),
                              blurStyle: BlurStyle.normal,
                              blurRadius: 5.0,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Scrollbar(
                            child: UserList(usersData: usersData),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (context) {
                              return CreateAdvisorBottomSheet(
                                adminRepository: adminRepository,
                                adminService: adminService,
                              );
                            },
                          );
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
          );
        }
      },
    );
  }
}
