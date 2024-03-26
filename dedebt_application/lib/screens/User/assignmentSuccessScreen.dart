import 'package:dedebt_application/routes/route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class assignmentSuccessScreen extends StatefulWidget {
  final int successType;
  final String assignmentId;
  // 0 เป็นการกรอกเอกสาร
  // 1 เป็นการนัดหมาย
  assignmentSuccessScreen(
      {super.key, required this.successType, required this.assignmentId});

  @override
  State<assignmentSuccessScreen> createState() => _assignmentSuccessScreen();
}

class _assignmentSuccessScreen extends State<assignmentSuccessScreen> {
  static Color appBarColor = const Color(0xFF444371);
  static Color textColor = const Color(0xFF36338C);
  static Color navBarColor = const Color(0xFF2DC09C);
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
              SizedBox(
                width: 45,
              ),
              Text(
                widget.successType == 0 ? "กรอกเอกสาร" : "นักหมายเวลา",
                style: TextStyle(fontSize: 24, color: Colors.white),
              )
            ],
          )),
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: 100,
                    color: textColor,
                  ),
                  Text(
                    widget.successType == 0
                        ? "การกรอกเอกสารเสร็จสิ้น"
                        : "นัดหมายเวลาเสร็จสิ้น",
                    style: TextStyle(fontSize: 24, color: textColor),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: navBarColor,
        height: 55,
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  //redirect ไปหน้าอื่นๆ
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: navBarColor,
                ),
                child: const Text(
                  'กลับหน้าหลัก',
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
