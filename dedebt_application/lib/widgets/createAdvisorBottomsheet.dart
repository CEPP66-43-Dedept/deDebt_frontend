// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, prefer_final_fields

import 'package:dedebt_application/models/advisorModel.dart';
import 'package:dedebt_application/repositories/adminRepository.dart';
import 'package:dedebt_application/services/adminService.dart';
import 'package:dedebt_application/variables/color.dart';
import 'package:flutter/material.dart';

class CreateAdvisorBottomSheet extends StatefulWidget {
  const CreateAdvisorBottomSheet(
      {Key? key, required this.adminRepository, required this.adminService})
      : super(key: key);
  final AdminRepository adminRepository;
  final AdminService adminService;
  @override
  _CreateAdvisorBottomSheetState createState() =>
      _CreateAdvisorBottomSheetState();
}

class _CreateAdvisorBottomSheetState extends State<CreateAdvisorBottomSheet> {
  final TextEditingController _controllerFirstName = TextEditingController();
  final TextEditingController _controllerLastName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerSpecialist = TextEditingController();
  final TextEditingController _controllerTel = TextEditingController();
  final TextEditingController _controllerSSN = TextEditingController();
  Future<void> _createAdvisor() async {
    try {
      final Advisors newAdvisor = Advisors(
          ssn: int.tryParse(_controllerSSN.text) ?? 0,
          firstname: _controllerFirstName.text,
          lastname: _controllerLastName.text,
          email: _controllerEmail.text,
          tel: _controllerTel.text,
          password: _controllerPassword.text,
          specialist: _controllerSpecialist.text,
          uid: "");
      await widget.adminService.createAdvisor(advisor: newAdvisor);
      Navigator.of(context).pop();
    } catch (e) {
      print('Error creating advisor: $e');
    }
  }

  @override
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
                    "เพิ่มที่ปรึกษา",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ],
            ),
            Scrollbar(
              child: Container(
                margin: EdgeInsets.all(30),
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _controllerSSN,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        hintText: "เลขประจำตัวประชาชน",
                        hintStyle: const TextStyle(
                          color: ColorGuide.blueAccent,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _controllerFirstName,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        hintText: "ชื่อจริง",
                        hintStyle: const TextStyle(
                          color: ColorGuide.blueAccent,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _controllerLastName,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        hintText: "นามสกุล",
                        hintStyle: const TextStyle(
                          color: ColorGuide.blueAccent,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _controllerEmail,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        hintText: "อีเมลล์",
                        hintStyle: const TextStyle(
                          color: ColorGuide.blueAccent,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _controllerPassword,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        hintText: "รหัสผ่าน",
                        hintStyle: const TextStyle(
                          color: ColorGuide.blueAccent,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _controllerTel,
                      keyboardType: TextInputType.phone,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        hintText: "เบอร์โทรศัพท์",
                        hintStyle: const TextStyle(
                          color: ColorGuide.blueAccent,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _controllerSpecialist,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        hintText: "ความถนัด",
                        hintStyle: const TextStyle(
                          color: ColorGuide.blueAccent,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateColor.resolveWith(
                  (states) => ColorGuide.greenAccent,
                ),
                fixedSize: MaterialStateProperty.all(Size(350, 60)),
              ),
              onPressed: _createAdvisor,
              child: Text(
                "เพิ่มผู้ใช้งาน",
                style: TextStyle(color: ColorGuide.white, fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controllerFirstName.dispose();
    _controllerLastName.dispose();
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    _controllerSpecialist.dispose();
    _controllerTel.dispose();
    _controllerSSN.dispose();
    super.dispose();
  }
}
