// ignore: file_names
import 'dart:ffi';
import 'package:logging/logging.dart';

import 'package:dedebt_application/routes/route.dart';
import 'package:dedebt_application/services/authService.dart';
import 'package:dedebt_application/variables/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLogin = true;
  @override
  void initState() {
    super.initState();
  }

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  bool inLogin = true;
  String? errorMessage = '';
  Future<void> signInWithEmailAndPassword() async {
    try {
      Logger('mylog').info('login Now');

      await Auth().signInWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        Logger('mylog').warning('failed');
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final boderInputStyle = OutlineInputBorder(
        borderSide: BorderSide.none, borderRadius: BorderRadius.circular(12.0));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
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
                ]),
          ),
          child: Column(children: [
            const SizedBox(height: 110),
            Container(
              decoration: const BoxDecoration(
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
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                        color: Color.fromRGBO(54, 51, 140, 0.26),
                        blurRadius: 5.0,
                        blurStyle: BlurStyle.normal)
                  ],
                  color: ColorGuide.white),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Text(
                      'เข้าสู่ระบบ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(children: [
                      SizedBox(
                        height: 45,
                        width: 250,
                        child: TextField(
                          controller: _controllerEmail,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              hintText: "อีเมล",
                              hintStyle: const TextStyle(
                                color: ColorGuide.blueAccent,
                                fontSize: 16,
                              ),
                              filled: true,
                              fillColor: ColorGuide.blueLighten,
                              focusedBorder: boderInputStyle,
                              enabledBorder: boderInputStyle,
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              prefixIcon: const Icon(Icons.account_circle),
                              prefixIconColor: ColorGuide.blueAccent),
                        ),
                      ),
                      const SizedBox(height: 25),
                      SizedBox(
                        height: 45,
                        width: 250,
                        child: TextField(
                          controller: _controllerPassword,
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              hintText: "รหัสผ่าน",
                              hintStyle: const TextStyle(
                                color: ColorGuide.blueAccent,
                                fontSize: 16,
                              ),
                              filled: true,
                              fillColor: ColorGuide.blueLighten,
                              focusedBorder: boderInputStyle,
                              enabledBorder: boderInputStyle,
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              prefixIcon: const Icon(
                                Icons.lock_rounded,
                                color: ColorGuide.blueAccent,
                              ),
                              prefixIconColor: Colors.black),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ]),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(ColorGuide.blueAccent),
                shadowColor: MaterialStateProperty.all(ColorGuide.black),
              ),
              onPressed: signInWithEmailAndPassword,
              child: const Text(
                'เข้าสู่ระบบ',
                style: TextStyle(color: ColorGuide.blueLight, fontSize: 16),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('ยังไม่มีบัญชีผู้ใช้?'),
                const SizedBox(width: 4),
                GestureDetector(
                  child: TextButton(
                    onPressed: () => context.go(AppRoutes.Register),
                    child: const Text(
                      'ลงทะเบียน',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
