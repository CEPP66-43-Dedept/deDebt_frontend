import 'package:flutter/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:go_router/go_router.dart';
import 'package:dedebt_application/routes/route.dart';

class assignmentUserScreen extends StatefulWidget {
  const assignmentUserScreen({super.key});

  @override
  State<assignmentUserScreen> createState() => _assignmentUserScreen();
}

class _assignmentUserScreen extends State<assignmentUserScreen> {
  static Color navbarColor = const Color(0xFF444371);
  int currentPage = 0;
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
    return _normalIcon[index];
  }

  Color getIconColors(int index) {
    return Colors.grey;
  }

  void onTap(int page) {
    switch (page) {
      case 0:
        context.go(AppRoutes.HOME_USER);

        break;
      case 1:
        context.go(AppRoutes.REQUEST_USER);

        break;
      case 2:
        context.go(AppRoutes.HISTORY_USER);

        break;
      case 3:
        context.go(AppRoutes.PROFILE_USER);

        break;
    }
  }

  Container getAssignmentStatusContainer(String status) {
    var textColor;
    var containerColor;
    switch (status) {
      case "ดำเนินการ":
        containerColor = const Color(0xFFE1E4F8);
        textColor = const Color(0xFF7673D3);
        break;
      case "เสร็จสิ้น":
        containerColor = const Color(0xFF2DC09C);
        textColor = const Color(0xFFFAFEFF);
        break;
      case "ยกเลิก":
        containerColor = const Color(0xFFF18F80);
        textColor = const Color(0xFFF0E6EC);
        break;
      default:
        return Container(
          child: Text(status),
        );
    }
    return Container(
      width: 83,
      height: 21,
      decoration: BoxDecoration(
          color: containerColor, borderRadius: BorderRadius.circular(20)),
      child: Center(
        child: Text(
          status,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          appBar: AppBar(
              backgroundColor: navbarColor,
              surfaceTintColor: Colors.transparent,
              toolbarHeight: 55,
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      //Icon function
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      size: 35,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  const Text(
                    "งานที่มอบหมาย",
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  )
                ],
              )),
          body: Scaffold(
              body: Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                RawScrollbar(
                  thumbColor: const Color(0xFFBBB9F4),
                  radius: const Radius.circular(20),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6.0, vertical: 10),
                  thickness: 5,
                  child: Container(
                      width: 415,
                      height: 501,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      child: DefaultTextStyle(
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: const Color(0xFF36338C),
                              fontSize: 15,
                            ),
                        child: ListView(children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(33, 29, 33, 25),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(28, 21, 28, 13),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFDAEAFA),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "ทำเอกสารหักเงินกับธนาคาร",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            "สถานะ: ",
                                            style: TextStyle(
                                                color: Color(0xFF5A55CA)),
                                          ),
                                          // create status container
                                          getAssignmentStatusContainer(
                                              "ดำเนินการ"),
                                        ],
                                      ),
                                      const Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "รายละเอียด: ",
                                            style: TextStyle(
                                                color: Color(0xFF5A55CA)),
                                          ),
                                          Expanded(
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    //Add Detail
                                                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum",
                                                    overflow:
                                                        TextOverflow.visible,
                                                  )
                                                ]),
                                          )
                                        ],
                                      ),
                                      const Row(
                                        children: [
                                          Text("วันสิ้นสุดการดำเนินการ: "),
                                          //วันดำเนินการ
                                          Text("-")
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ]),
                      )),
                ),
                Container(
                  width: 390,
                  height: 165,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  // แจ้งหมายเหตุ function
                                  print('Next button pressed');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFF18F80),
                                ),
                                child: const Text(
                                  'แจ้งหมายเหตุ',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white), // Set text color
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Center Row horizontally
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  // Handle button press
                                  print('Next button pressed');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF2DC09C),
                                ),
                                child: const Text(
                                  'เสร็จสิ้น',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white), // Set text color
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
          bottomNavigationBar: SizedBox(
              height: 55,
              child: BottomAppBar(
                color: navbarColor,
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
              ))),
    );
  }
}
