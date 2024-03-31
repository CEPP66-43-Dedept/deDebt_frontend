import 'dart:async';

import 'package:dedebt_application/models/fillAssignModel.dart';
import 'package:dedebt_application/models/requestModel.dart';
import 'package:dedebt_application/models/userModel.dart';
import 'package:dedebt_application/repositories/userRepository.dart';
import 'package:dedebt_application/routes/route.dart';
import 'package:dedebt_application/screens/User/docAssignmentScreen.dart';
import 'package:dedebt_application/services/userService.dart';
import 'package:dedebt_application/variables/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dedebt_application/models/assignmentModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class fillDocumentUserScreen extends StatefulWidget {
  final String assignmentId;
  const fillDocumentUserScreen({super.key, required this.assignmentId});

  @override
  State<fillDocumentUserScreen> createState() => _fillDocumentUserScreen();
}

class _fillDocumentUserScreen extends State<fillDocumentUserScreen> {
  static Color appBarColor = const Color(0xFF444371);
  final AccountNumberController = TextEditingController();
  final AccountNameController = TextEditingController();
  final CardNumberController = TextEditingController();
  final ExpiredDateController = TextEditingController();

  late final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late final UserRepository userRepository =
      UserRepository(firestore: firestore);
  late final UserService userService =
      UserService(userRepository: userRepository);
  late StreamController<Assignment?> _userAssignmentController;
  late FillAssignment? dataAssignment;
  late User? user = FirebaseAuth.instance.currentUser;
  final DeliveryAddressController = TextEditingController();
  final PostNoController = TextEditingController();
  final PhoneController = TextEditingController();
  late Stream<Users?> _userDataStream;

  void saveDataToFirestore(FillAssignment data) async {
    try {
      final CollectionReference assignmentsCollection =
          FirebaseFirestore.instance.collection('documents');
      await assignmentsCollection.doc(data.id).set(data.toMap());
      print('Data saved successfully to Firestore!');
    } catch (error) {
      print('Error saving data: $error');
    }
  }

  Future<Users?> _getUserData(String userId) async {
    Map<String, dynamic>? userData = await userService.getUserData(userId);
    if (userData != null) {
      Users user = Users.fromMap(userData);
      return user;
    } else {
      throw Exception('User data not found');
    }
  }

  Future<void> _updateassignmentStatus(String assignmentID) async {
    await userService.updateAssignmentStatus(assignmentID);
  }

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

  void initState() {
    super.initState();
    _userDataStream = _getUserDataStream(user!.uid);
  }

  Stream<Users?> _getUserDataStream(String userId) {
    return Stream<Map<String, dynamic>?>.fromFuture(
            userService.getUserData(userId))
        .map((userData) => userData != null ? Users.fromMap(userData) : null);
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
                onPressed: () {
                  context.go(AppRoutes.REQUEST_USER);
                },
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
          child: SingleChildScrollView(
            child: GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    const Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.account_balance,
                          size: 65,
                          color: Color(0xFF36338C),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Flexible(
                          child: Text(
                            //เปลี่ชนชื่อธนาตาร
                            "ใบหักเงินจากธนาคารกสิกรไทย",
                            overflow: TextOverflow.visible,
                            style: TextStyle(
                                fontSize: 24, color: Color(0xFF36338C)),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 470,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          width: 360,
                          height: 490,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                          ),
                          child: ListView(
                            children: [
                              createTextField("หมายเลขบัญชี", true,
                                  AccountNumberController),
                              createTextField(
                                  "ชื่อบัญชี", false, AccountNameController),
                              createTextField(
                                  "หมายเลขบัตร", true, CardNumberController),
                              createTextField(
                                  "บัตรหมดอายุ", false, ExpiredDateController),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
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
                      onPressed: () async {
                        // แจ้งหมายเหตุ function
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // ปุ่มย้อนกลับ
                                  IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    icon: Icon(Icons.arrow_back),
                                  ),
                                  Expanded(
                                    child: FutureBuilder<Users?>(
                                      future: _getUserData(user!.uid),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          // Return a loading indicator if data is still loading
                                          return Scaffold(
                                            body: CircularProgressIndicator(),
                                          );
                                        } else if (snapshot.hasError) {
                                          // Return an error message if an error occurred
                                          return Text(
                                              'Error: ${snapshot.error}');
                                        } else {
                                          // If data is available, build your widget accordingly
                                          Users? currentUser = snapshot.data;
                                          if (currentUser != null) {
                                            FillAssignment fillAssignment =
                                                FillAssignment(
                                              id: widget.assignmentId,
                                              data: [
                                                AccountNumberController.text,
                                                AccountNameController.text,
                                                CardNumberController.text,
                                                ExpiredDateController.text,
                                                "${currentUser.firstname} ${currentUser.lastname}",
                                                "${currentUser.ssn}"
                                              ],
                                            );
                                            return DocAssignScreen(
                                                lstString: fillAssignment);
                                          } else {
                                            // Handle the case when user data is not available
                                            print("User data is not available");
                                            return Container();
                                          }
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorGuide.blueDarken,
                      ),
                      child: const Text(
                        'พรีวิว',
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
                        _updateassignmentStatus(widget.assignmentId);
                        _userDataStream.listen((Users? currentUser) {
                          if (currentUser != null) {
                            FillAssignment fillAssignment = FillAssignment(
                              id: widget.assignmentId,
                              data: [
                                AccountNumberController.text,
                                AccountNameController.text,
                                CardNumberController.text,
                                ExpiredDateController.text,
                                "${currentUser.firstname} ${currentUser.lastname}",
                                "${currentUser.ssn}"
                              ],
                            );
                            saveDataToFirestore(fillAssignment);
                            context.go(AppRoutes.ASSIGNMENT_PREVIEW_DOC_USER +
                                '/' +
                                widget.assignmentId);
                          } else {
                            // Handle the case when user data is not available
                            print("User data is not available");
                          }
                        });
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
