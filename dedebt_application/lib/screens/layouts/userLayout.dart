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
  int currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  final List<IconData> _normalIcon = [
    Icons.home,
    Icons.attach_money,
    Icons.replay,
    Icons.person
  ];
  final List<IconData> _outlinedIcon = [
    Icons.home_outlined,
    Icons.attach_money_outlined,
    Icons.replay_outlined,
    Icons.person_outline
  ];
  @override
  void initState() {
    super.initState();
  }

  IconData getIcon(int index) {
    return currentPage == index ? _normalIcon[index] : _outlinedIcon[index];
  }

  Color getIconColors(int index) {
    return currentPage == index ? Colors.white : Colors.grey;
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
        children: [homeUserScreen()],
      ),
      bottomNavigationBar: SizedBox(
        height: 55,
        child: BottomAppBar(
          color: const Color(0xFF444371),
          padding: const EdgeInsets.all(0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(getIcon(0), size: 35, color: getIconColors(0)),
                onPressed: () {
                  onTap(0);
                },
              ),
              IconButton(
                icon: Icon(getIcon(1), size: 35, color: getIconColors(1)),
                onPressed: () {
                  onTap(1);
                },
              ),
              IconButton(
                icon: Icon(getIcon(2), size: 35, color: getIconColors(2)),
                onPressed: () {
                  onTap(2);
                },
              ),
              IconButton(
                icon: Icon(getIcon(3), size: 35, color: getIconColors(3)),
                onPressed: () {
                  onTap(3);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
