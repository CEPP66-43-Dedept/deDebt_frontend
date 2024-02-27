import 'package:flutter/material.dart';

class homeUserScreen extends StatefulWidget {
  const homeUserScreen({super.key});

  @override
  State<homeUserScreen> createState() => _homeUserScreenState();
}

class _homeUserScreenState extends State<homeUserScreen> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text("Home user"),
      ),
    );
  }
}
