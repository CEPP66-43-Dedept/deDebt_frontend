// ignore_for_file: prefer_const_constructors

import 'package:dedebt_application/models/advisorModel.dart';
import 'package:dedebt_application/repositories/adminRepository.dart';
import 'package:dedebt_application/services/adminService.dart';
import 'package:dedebt_application/variables/color.dart';
import 'package:dedebt_application/variables/rolesEnum.dart';
import 'package:dedebt_application/widgets/createAdvisorBottomsheet.dart';
import 'package:flutter/material.dart';

class DeleteUserBottomsheet extends StatefulWidget {
  const DeleteUserBottomsheet(
      {Key? key,
      required this.adminRepository,
      required this.adminService,
      required this.index,
      required this.uid,
      required this.role})
      : super(key: key);

  final AdminRepository adminRepository;
  final AdminService adminService;
  final int index;
  final String uid;
  final Roles role;

  @override
  _DeleteUserBottomsheetState createState() => _DeleteUserBottomsheetState();
}

class _DeleteUserBottomsheetState extends State<DeleteUserBottomsheet> {
  late Future<Map<String, dynamic>> _userData;

  @override
  void initState() {
    super.initState();
    _userData = _getUserData(widget.uid, widget.role);
  }

  Future<Map<String, dynamic>> _getUserData(
    String uid,
    Roles role,
  ) async {
    try {
      return await widget.adminService.getUserDataById(uid, role);
    } catch (e) {
      return {};
    }
  }

  Future<void> _deleteUserById(String uid, Roles role) async {
    try {
      await widget.adminService.deleteUserByID(uid: uid, role: role);
    } catch (e) {
      print("error");
    }
  }

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 800,
        width: 400,
        decoration: BoxDecoration(
          color: ColorGuide.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.arrow_back_ios, color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "จัดการผู้ใช้",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ],
            ),
            FutureBuilder<Map<String, dynamic>>(
              future: _userData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  Map<String, dynamic> userData = snapshot.data ?? {};
                  return Container(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(children: [
                        Row(
                          children: [
                            Text("UID : "),
                            Text(userData["uid"]),
                          ],
                        ),
                        Row(
                          children: [
                            Text("email : "),
                            Text(userData["email"]),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Firstname : "),
                            Text(userData["firstName"]),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Lastname : "),
                            Text(userData["lastName"]),
                          ],
                        ),
                        Row(
                          children: [
                            Text("tel : "),
                            Text(userData["tel"]),
                          ],
                        )
                      ]),
                    ),
                  );
                }
              },
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateColor.resolveWith(
                  (states) => ColorGuide.redAccent,
                ),
                fixedSize: MaterialStateProperty.all(Size(350, 60)),
              ),
              onPressed: () {
                _deleteUserById(widget.uid, widget.role);
              },
              child: Text(
                "ลบผู้ใช้รายนี้",
                style: TextStyle(color: ColorGuide.white, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
