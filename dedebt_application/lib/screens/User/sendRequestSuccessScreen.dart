import 'package:dedebt_application/routes/route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class sendRequestSuccessScreen extends StatefulWidget {
  const sendRequestSuccessScreen({super.key});

  @override
  State<sendRequestSuccessScreen> createState() => _sendRequestSuccessScreen();
}

class _sendRequestSuccessScreen extends State<sendRequestSuccessScreen> {
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
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_back,
                  size: 35,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 45,
              ),
              const Text(
                "ลงทะเบียนคำร้อง",
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
                    "ลงทะเบียนคำร้องเสร็จสิ้น",
                    style: TextStyle(fontSize: 24, color: textColor),
                  ),
                  Text(
                    "กรุณารอระบบดำเนินการหาที่ปรึกษา",
                    style: TextStyle(fontSize: 16, color: textColor),
                  )
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
                  context.go(AppRoutes.HOME_USER);
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
