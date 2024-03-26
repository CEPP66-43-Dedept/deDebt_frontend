import 'dart:async';

import 'package:dedebt_application/repositories/userRepository.dart';
import 'package:dedebt_application/services/userService.dart';
import 'package:flutter/material.dart';
import 'package:dedebt_application/models/assignmentModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class fillDocumentUserScreen extends StatefulWidget {
  final String assignmentId;
  const fillDocumentUserScreen({super.key, required this.assignmentId});

  @override
  State<fillDocumentUserScreen> createState() => _fillDocumentUserScreen();
}

class _fillDocumentUserScreen extends State<fillDocumentUserScreen> {
  static Color appBarColor = const Color(0xFF444371);
  late final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late final UserRepository userRepository =
      UserRepository(firestore: firestore);
  late final UserService userService =
      UserService(userRepository: userRepository);
  late StreamController<Assignment?> _userAssignmentController;

  final AccountController = TextEditingController();
  final AccountTypeContoller = TextEditingController();
  final BranchController = TextEditingController();
  final DeliveryAddressController = TextEditingController();
  final PostNoController = TextEditingController();
  final PhoneController = TextEditingController();
  Container createTextField(
      String TextBanner, bool isNumberOnly, TextEditingController controller) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(TextBanner),
          ),
          Container(
            width: 330,
            height: 52,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              controller: controller,
              keyboardType:
                  isNumberOnly ? TextInputType.number : TextInputType.text,
              decoration: const InputDecoration(
                hintText: "Type your info Here",
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: appBarColor,
          surfaceTintColor: Colors.transparent,
          toolbarHeight: 55,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_back,
                  size: 35,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 65,
              ),
              const Text(
                "กรอกเอกสาร",
                style: TextStyle(fontSize: 24, color: Colors.white),
              )
            ],
          )),
      body: Align(
        alignment: Alignment.center,
        child: DefaultTextStyle(
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: const Color(0xFF000000),
                fontSize: 18.0,
              ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                const Icon(
                  Icons.account_balance,
                  size: 65,
                  color: Color(0xFF36338C),
                ),
                const SizedBox(
                  width: 20,
                ),
                Flexible(
                  child: const Text(
                    //เปลี่ชนชื่อธนาตาร
                    "ใบหักเงินจากธนาคารกสิกรไทย",
                    overflow: TextOverflow.visible,
                    style: TextStyle(fontSize: 24, color: Color(0xFF36338C)),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: RawScrollbar(
                thumbColor: const Color(0xFFBBB9F4),
                thumbVisibility: true,
                radius: const Radius.circular(20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 6.0, vertical: 10),
                thickness: 5,
                child: Container(
                  width: 360,
                  height: 490,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: ListView(
                    children: [
                      createTextField("เลขที่บัญชี", true, AccountController),
                      createTextField(
                          "ประเภทบัญชี", false, AccountTypeContoller),
                      createTextField(
                          "สำนักงาน / สาขา", false, BranchController),
                      createTextField(
                          "ที่อยู่กาาจัดส่ง", false, DeliveryAddressController),
                      createTextField("รหัสไปรษณีย์", false, PostNoController),
                      createTextField("โทรศัพท์มือถือ", true, PhoneController),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
      bottomNavigationBar: Container(
        width: 390,
        height: 165,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // แจ้งหมายเหตุ function
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF18F80),
                      ),
                      child: const Text(
                        'ยกเลิก',
                        style: TextStyle(fontSize: 18.0, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle button press
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2DC09C),
                      ),
                      child: const Text(
                        'สร้างเอกสาร',
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white), // Set text color
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
