import 'package:dedebt_application/variables/color.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFF2F5FF),
                Color(0xFFF2F5FF),
                ColorGuide.whiteAccent,
              ]),
        ),
        child: Column(children: [
          const SizedBox(height: 110),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 25.0,
                horizontal: 60.0,
              ),
              child: Image.asset(
                "assets/images/Logo.png",
                width: 150,
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
        ]),
      ),
    );
  }
}
