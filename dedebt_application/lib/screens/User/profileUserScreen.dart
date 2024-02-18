// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:dedebt_application/screens/layouts/userLayout.dart';

class profileUserScreen extends StatefulWidget {
  const profileUserScreen({super.key});

  @override
  State<profileUserScreen> createState() => _profileUserScreen();
}

class _profileUserScreen extends State<profileUserScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //throw UnimplementedError();
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 25, 10, 0),
            child: Text(
              "My Profile",
              style: const TextStyle(fontSize: 24),
            ),
          )
        ],
      )),
    );
  }
}
