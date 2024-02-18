// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:dedebt_application/screens/layouts/userLayout.dart';

class historyUserScreen extends StatefulWidget {
  const historyUserScreen({super.key});

  @override
  State<historyUserScreen> createState() => _historyUserScreen();
}

class _historyUserScreen extends State<historyUserScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 25, 10, 0),
            child: Text(
              "ประวัติคำร้อง",
              style: const TextStyle(fontSize: 24),
            ),
          )
        ],
      )),
    );
    ;
  }
}
