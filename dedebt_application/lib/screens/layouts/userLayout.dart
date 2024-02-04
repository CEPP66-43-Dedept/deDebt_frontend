import 'package:dedebt_application/routes/route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class UserLayout extends StatefulWidget {
  const UserLayout({super.key});

  @override
  State<UserLayout> createState() => _UserLayoutState();
}

class _UserLayoutState extends State<UserLayout> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    const primaryColor = Color(0xFFF3F5FE);
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
                    padding: EdgeInsets.symmetric(horizontal: 10),
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
        body: Align(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(10, 25, 10, 0),
                child: Text(
                  "สวัสดี [User]",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    "คำร้องของคุณ",
                    style: TextStyle(fontSize: 24),
                  )),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF36338C),
                  borderRadius: BorderRadius.circular(20),
                ),
                width: 324,
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.symmetric(vertical: 16.0),
                child: DefaultTextStyle(
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.white,
                        fontSize: 15.0,
                      ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            "การแก้หนี้จากธนาคาร",
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                const Text("สถานะ : "),
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF2DC09C),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  child: const Text(
                                    "เสร็จสิ้น",
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const Text("ผู้รับผิดชอบ : "),
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF0F4FD),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: const Text(
                                    "นาย ABC DEF",
                                    style: TextStyle(color: Color(0xFF2DC09C)),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            const Row(
                              children: [Text("ประเภท : "), Text("oooooo")],
                            ),
                            const SizedBox(height: 5),
                            const Row(
                              children: [Text("รายละเอียด : "), Text("oooooo")],
                            ),
                          ],
                        ),
                      ]),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "การนัดหมาย",
                  style: TextStyle(fontSize: 24),
                ),
              ),
              RawScrollbar(
                thumbColor: const Color(0xFFBBB9F4),
                thumbVisibility: true,
                radius: const Radius.circular(20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 6.0, vertical: 10),
                thickness: 5,
                child: Container(
                  height: 309,
                  width: 324,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      DefaultTextStyle(
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: const Color(0xFF36338C),
                              fontSize: 15.0,
                            ),
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(19, 10, 19, 0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFDAEAFA),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "นัดโทรคุยโทรศัพท์",
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                    const Text("การแก้หนี้จากธนาคาร oooooo"),
                                    Row(
                                      children: [
                                        const Text(
                                          "สถานะ : ",
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF2DC09C),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 25.0),
                                          child: const Text(
                                            "เสร็จสิ้น",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      DefaultTextStyle(
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: const Color(0xFF36338C),
                              fontSize: 15.0,
                            ),
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(19, 10, 19, 0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFDAEAFA),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "นัดโทรคุยโทรศัพท์",
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                    const Text("การแก้หนี้จากธนาคาร oooooo"),
                                    Row(
                                      children: [
                                        const Text(
                                          "สถานะ : ",
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF2DC09C),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 25.0),
                                          child: const Text(
                                            "เสร็จสิ้น",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      DefaultTextStyle(
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: const Color(0xFF36338C),
                              fontSize: 15.0,
                            ),
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(19, 10, 19, 0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFDAEAFA),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "นัดโทรคุยโทรศัพท์",
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                    const Text("การแก้หนี้จากธนาคาร oooooo"),
                                    Row(
                                      children: [
                                        const Text(
                                          "สถานะ : ",
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF2DC09C),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 25.0),
                                          child: const Text(
                                            "เสร็จสิ้น",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      DefaultTextStyle(
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: const Color(0xFF36338C),
                              fontSize: 15.0,
                            ),
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(19, 10, 19, 0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFDAEAFA),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "นัดโทรคุยโทรศัพท์",
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                    const Text("การแก้หนี้จากธนาคาร oooooo"),
                                    Row(
                                      children: [
                                        const Text(
                                          "สถานะ : ",
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF2DC09C),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 25.0),
                                          child: const Text(
                                            "เสร็จสิ้น",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () => context.go(AppRoutes.INITIAL),
                child: const Text('Go to the user screen'),
              )
            ],
          ),
        ));
  }
}
