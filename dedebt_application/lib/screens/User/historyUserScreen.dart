// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:dedebt_application/screens/layouts/userLayout.dart';
import 'package:dedebt_application/models/requestModel.dart';

class historyUserScreen extends StatefulWidget {
  const historyUserScreen({super.key});

  @override
  State<historyUserScreen> createState() => _historyUserScreen();
}

class _historyUserScreen extends State<historyUserScreen> {
  //Mockup Data

  @override
  void initState() {
    super.initState();
  }

  dynamic getBody() {
    bool isHavedata = false;
    if (isHavedata) {
      return Stack(
        children: [
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                "ประวัติคำร้อง",
                style: TextStyle(fontSize: 24),
              ),
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
                  const Text("ไม่มีคำร้อง"),
                ],
              ),
            ),
          ),
        ],
      );
    } else {
      List<Widget> containerList = [
        const SizedBox(height: 10),
      ];

      List<Request> _request = [];
      //สร้าง Listview ที่จะมีคำร้องต่างๆ ของ User
      for (Request requestItem in _request) {
        Widget container = UserLayout.createRequestBox(requestItem);
        containerList.add(container);
        containerList.add(const SizedBox(height: 10));
      }
      return Scaffold(
        body: Center(
            child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 25, 10, 20),
              child: Text(
                "ประวัติคำร้อง",
                style: TextStyle(fontSize: 24),
              ),
            ),
            RawScrollbar(
              thumbColor: const Color(0xFFBBB9F4),
              thumbVisibility: true,
              radius: const Radius.circular(20),
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
              thickness: 5,
              child: DefaultTextStyle(
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                child: SizedBox(
                  height: 552,
                  width: 344,
                  child: ListView.builder(
                    itemCount: containerList.length,
                    itemBuilder: (context, index) {
                      return containerList[index];
                    },
                  ),
                ),
              ),
            )
          ],
        )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return getBody();
  }
}
