import 'package:flutter/material.dart';

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
    //throw UnimplementedError();
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
  }
}
