import 'package:dedebt_application/routes/route.dart';
import 'package:dedebt_application/screens/User/profileUserScreen.dart';
import 'package:dedebt_application/widgets/navbar.dart';
import 'package:dedebt_application/screens/User/homeUserScreen.dart';
import 'package:dedebt_application/screens/User/requestUserScreen.dart';
import 'package:dedebt_application/screens/User/historyUserScreen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserLayout extends StatefulWidget {
  const UserLayout({super.key});

  @override
  State<UserLayout> createState() => _UserLayoutState();
}

class _UserLayoutState extends State<UserLayout> {
  static Color primaryColor = const Color(0xFFF3F5FE);
  int currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
  }

  void onPageChanged(int page) {
    setState(() {
      currentPage = page;
    });
  }

  void onTap(int page) {
    setState(() {
      currentPage = page;
      _pageController.jumpToPage(page);
    });
  }

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
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: onPageChanged,
        children: [
          homeUserScreen(),
          requestUserScreen(),
          historyUserScreen(),
          profileUserScreen()
        ],
      ),
      bottomNavigationBar: NavBar(
        currUsertype: UserType.User,
        currentPage: currentPage,
        onTap: onTap,
      ),
    );
  }
}
