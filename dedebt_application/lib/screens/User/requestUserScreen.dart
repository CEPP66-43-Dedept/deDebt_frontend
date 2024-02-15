import 'package:flutter/material.dart';
import 'package:dedebt_application/screens/layouts/userLayout.dart';

class requestUserScreen extends StatefulWidget {
  const requestUserScreen({super.key});

  @override
  State<requestUserScreen> createState() => _requestUserScreen();
}

class _requestUserScreen extends State<requestUserScreen> {
  @override
  void initState() {
    super.initState();
  }

  Scaffold getBody() {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 25, 10, 0),
                  child: Text(
                    "คำร้องปัจจุบัน",
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
                // Add any other content here
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/Nothing.png"),
                  Text("ไม่มีคำร้องที่ดำเนินการอยู่ในขณะนี้ "),
                  Text("สามารถกดลงทะเบียนคำร้องได้ที่ปุ่ม \‘+\’")
                ],
              ),
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
                    // Handle button press
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

  @override
  Widget build(BuildContext context) {
    return UserLayout(
      Body: getBody(),
      currentPage: 1,
    );
  }
}
