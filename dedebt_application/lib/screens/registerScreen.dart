import 'package:dedebt_application/variables/color.dart';
import 'package:dedebt_application/widgets/regiswidget.dart';
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
      appBar: AppBar(
        backgroundColor: ColorGuide.blueLight,
        title: Row(
          children: [
            Image.asset(
              "assets/images/Logo.png",
              width: 100,
            ),
            const SizedBox(
              height: 100,
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        // Wrap ด้วย SingleChildScrollView
        child: Container(
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
              ],
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "ลงทะเบียนผู้ใช้",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const RegisterFormWidget(),
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: true, // เซ็ต resizeToAvoidBottomInset เป็น true
    );
  }
}
