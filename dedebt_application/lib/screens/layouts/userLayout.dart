import 'package:dedebt_application/routes/route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dedebt_application/models/userModel.dart';
import 'package:dedebt_application/models/requestModel.dart';

class UserLayout extends StatefulWidget {
  final Widget Body;
  int currentPage = 0;
  UserLayout({Key? key, required this.Body, required this.currentPage})
      : super(key: key);
  @override
  State<UserLayout> createState() => _UserLayoutState();

  static Container getStatusContainer(request uRequest) {
    Color containerColor;
    bool isCase1 = false;
    switch (uRequest.requestStatus) {
      case "จัดหาที่ปรึกษา":
        containerColor = const Color(0xFFE1E4F8);
        isCase1 = true;
        break;
      case "กำลังปรึกษา":
        containerColor = const Color(0xFFF18F80);
        break;
      case "เสร็จสิ้น":
        containerColor = const Color(0xFF2DC09C);
        break;
      default:
        containerColor = const Color(0xFFFFFFFF);
        break;
    }
    Container statusContainer = Container(
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Text(
        uRequest.requestStatus,
        style: TextStyle(color: isCase1 ? const Color(0xFF7673D3) : null),
      ),
    );
    return statusContainer;
  }
}

class _UserLayoutState extends State<UserLayout> {
  static Color primaryColor = const Color(0xFFF3F5FE);
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
  IconData getIcon(int index) {
    return widget.currentPage == index
        ? _normalIcon[index]
        : _outlinedIcon[index];
  }

  Color getIconColors(int index) {
    return widget.currentPage == index ? Colors.white : Colors.grey;
  }

  @override
  void initState() {
    super.initState();
  }

  void onTap(int page) {
    switch (page) {
      case 0:
        if (widget.currentPage != 0) {
          context.go(AppRoutes.HOME_USER);
        }
        break;
      case 1:
        if (widget.currentPage != 1) {
          context.go(AppRoutes.REQUEST_USER);
        }
        break;
      case 2:
        if (widget.currentPage != 2) {
          context.go(AppRoutes.HISTORY_USER);
        }
        break;
      case 3:
        if (widget.currentPage != 3) {
          context.go(AppRoutes.PROFILE_USER);
        }
        break;
    }
    setState(() {
      widget.currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          surfaceTintColor: Colors.transparent,
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
        body: widget.Body,
        bottomNavigationBar: SizedBox(
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
            )));
  }
}
