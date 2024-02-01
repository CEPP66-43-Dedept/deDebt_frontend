import 'package:dedebt_application/routes/route.dart';
import 'package:dedebt_application/variables/color.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(color: ColorGuide.whiteAccent),
        child: ListView(
          children: [
            const SizedBox(height: 100),
            Container(
              decoration: BoxDecoration(
                color: ColorGuide.white,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 25.0,
                  horizontal: 60.0,
                ),
                child: Image.asset(
                  "assets/images/Logo.png",
                  width: 75,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.INITIAL),
              child: const Text('Go to the Details screen'),
            ),
          ],
        ),
      ),
    );
  }
}
