import 'package:dedebt_application/services/authService.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:dedebt_application/routes/route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AdminLayout extends StatefulWidget {
  final Widget Body;
  const AdminLayout({
    Key? key,
    required this.Body,
  }) : super(key: key);

  @override
  State<AdminLayout> createState() => _AdminLayoutState();
}

class _AdminLayoutState extends State<AdminLayout> {
  static Color primaryColor = const Color(0xFFF3F5FE);
  @override
  void initState() {
    super.initState();
  }

  Future<void> signOut() async {
    try {
      await Auth().signOut();
    } on FirebaseAuthException {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        toolbarHeight: 55,
        title: Column(
          children: [
            Container(
              constraints: const BoxConstraints(
                maxHeight: 50,
                maxWidth: double.infinity,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/images/Logo.png',
                      fit: BoxFit.contain,
                    ),
                    IconButton(
                      icon: Icon(Icons.exit_to_app),
                      onPressed: () {
                        signOut();
                        context.go(AppRoutes.INITIAL);
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: widget.Body,
    );
  }
}
