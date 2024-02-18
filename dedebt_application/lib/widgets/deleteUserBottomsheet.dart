// ignore_for_file: prefer_const_constructors

import 'package:dedebt_application/variables/color.dart';
import 'package:flutter/material.dart';

class DeleteUserBottomsheet extends StatelessWidget {
  const DeleteUserBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 600,
        width: 400,
        decoration: BoxDecoration(
            color: ColorGuide.white, borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "เพิ่มที่ปรึกษา",
                style: TextStyle(fontSize: 24),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith(
                      (states) => ColorGuide.greenAccent),
                  fixedSize: MaterialStateProperty.all(Size(350, 60))),
              onPressed: () {},
              child: Text(
                "เพิ่มผู้ใช้งาน",
                style: TextStyle(color: ColorGuide.white, fontSize: 20),
              ),
            )
          ],
        ));
  }
}
