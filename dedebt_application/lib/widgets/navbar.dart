import 'package:flutter/material.dart';

enum UserType {
  User,
  Advisor,
  Matcher,
  Admin,
}

class NavBar extends StatelessWidget {
  final Function(int) onTap;
  final UserType currUsertype;
  int currentPage;
  final Color navbarcolor = const Color(0xFF444371);
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

  NavBar({
    super.key,
    required this.currUsertype,
    required this.onTap,
    required this.currentPage,
  });

  IconData getIcon(int index) {
    return currentPage == index ? _normalIcon[index] : _outlinedIcon[index];
  }

  Color getIconColors(int index) {
    return currentPage == index ? Colors.white : Colors.grey;
  }
  
  SizedBox getNavbar() {
    return SizedBox(
        height: 55,
        child: BottomAppBar(
          color: navbarcolor,
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
        ));
  }

  SizedBox getAdminNavbar() {
    return SizedBox(
        height: 55,
        child: BottomAppBar(
          color: navbarcolor,
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
                icon: Icon(getIcon(3), size: 35, color: getIconColors(3)),
                onPressed: () {
                  onTap(1);
                },
              )
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    switch (currUsertype) {
      case UserType.Admin:
        return getAdminNavbar();
      default:
        return getNavbar();
    }
  }
}
