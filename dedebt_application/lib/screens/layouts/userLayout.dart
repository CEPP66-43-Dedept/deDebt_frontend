import 'package:dedebt_application/routes/route.dart';
import 'package:dedebt_application/screens/User/homeUserScreen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserLayout extends StatefulWidget {
  const UserLayout({super.key});

  @override
  State<UserLayout> createState() => _UserLayoutState();
}

class _UserLayoutState extends State<UserLayout> {
  static Color primaryColor = Color(0xFFF3F5FE);

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                      Image.asset(
                        'assets/images/Backicon.png',
                        fit: BoxFit.contain,
                        width: 34,
                        height: 30,
                      )
                    ],
                  ),
                )),
          ],
        ),
        backgroundColor: primaryColor,
      ),
      body: PageView(
        children: [homeUserScreen()],
      ),
      bottomNavigationBar: Container(
        height: 55,
        child: ElevatedButton(
            onPressed: () => context.go(AppRoutes.INITIAL),
            child: const Text('Go to the user screen')),
      ),
    );
  }
}
/*              ElevatedButton(
                  onPressed: () => context.go(AppRoutes.INITIAL),
                  child: const Text('Go to the user screen'),
                )*/