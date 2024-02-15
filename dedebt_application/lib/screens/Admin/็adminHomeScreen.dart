import 'package:dedebt_application/variables/color.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F5FF),
      body: Center(
        child: Column(children: [
          SizedBox(
            height: 80,
          ),
          Text(
            "จัดการผู้ใช้",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 20,
          ),
          ToggleSwitch(
            fontSize: 16,
            minWidth: 120.0,
            cornerRadius: 20.0,
            activeBgColors: [
              const [ColorGuide.blueAccent],
              [ColorGuide.blueAccent!]
            ],
            activeFgColor: ColorGuide.blueLight,
            inactiveBgColor: ColorGuide.whiteAccent,
            inactiveFgColor: ColorGuide.blueAccent,
            initialLabelIndex: 1,
            totalSwitches: 2,
            labels: ['ที่ปรึกษา', 'ผู้ใช้งาน'],
            radiusStyle: true,
            onToggle: (index) {
              print('switched to: $index');
            },
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: 350,
            height: 500,
            decoration: BoxDecoration(
                color: ColorGuide.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: const Color.fromARGB(255, 199, 198, 255),
                      blurStyle: BlurStyle.normal,
                      blurRadius: 5.0)
                ]),
          ),
        ]),
      ),
    );
  }
}
