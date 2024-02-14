import 'package:flutter/material.dart';

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
              "คำร้องปัจจุบัน",
              style: const TextStyle(fontSize: 24),
            ),
          )
        ],
      )),
    );
  }
}
