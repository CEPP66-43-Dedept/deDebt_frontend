import 'package:flutter/material.dart';
import 'package:dedebt_application/screens/layouts/userLayout.dart';
import 'package:dedebt_application/models/requestModel.dart';

class historyUserScreen extends StatefulWidget {
  const historyUserScreen({super.key});

  @override
  State<historyUserScreen> createState() => _historyUserScreen();
}

class _historyUserScreen extends State<historyUserScreen> {
  late Future<dynamic> _historyFuture;
  //Mockup Data
  request userrequest = request(
      id: 0,
      title: "การแก้หนี้กับธนาคารกสิกรไทย",
      detail:
          "123456แก้หนี้ที่ค้างคามานานมากมายแก้หนี้ที่ค้างคามานานมากมายแก้หนี้ที่ค้างคามานานมากมาย1234567890แก้หนี้ที่ค้างคามานานมากมายแก้หนี้ที่ค้างคามานานมากมายแก้หนี้ที่ค้างคามานานมากมาย1234567890แก้หนี้ที่ค้างคามานานมากมายแก้หนี้ที่ค้างคามานานมากมายแก้หนี้ที่ค้างคามานานมากมาย1234567890",
      userId: 0,
      advisorId: 0,
      requestStatus: "เสร็จสิ้น",
      type: [
        "หนี้บัตรเครติด",
        "สินเชื่อส่วนบุคคล",
      ], //[หนี้บัตรเครติด,สินเชื่อส่วนบุคคล,หนี้บ้าน,หนี้จำนำรถ,หนี้เช่าซื้อรถ]
      debtStatus: ["Normal"],
      provider: ["กสิกร"],
      revenue: [10000],
      expense: [1000000],
      burden:
          "1/3ของรายได้", //ผ่อนหนี้ [1/3ของรายได้,1/3-1/2ของรายได้,1/2-2/3ของรายได้,มากกว่า 2/3 ของรายได้ ]
      propoty: 25000,
      assignmentId: [],
      appointmentDate: [DateTime(2024, 2, 17)],
      appointmentStatus: [
        "เสร็จสิ้น",
      ]);

  @override
  void initState() {
    super.initState();
    _historyFuture = getMultipleUserRequest();
  }

  Future<List<request>?> getMultipleUserRequest() async {
    //ไม่มี user request ใน db
    //return null;

    //Mockup data
    return [userrequest, userrequest, userrequest, userrequest];
  }

  FutureBuilder getBody() {
    return FutureBuilder(
        future: _historyFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching request'));
          } else if (snapshot.data == null) {
            // ไม่มีข้อมูลใน db
            return Stack(
              children: [
                const Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      "ประวัติคำร้อง",
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/Nothing.png"),
                        const Text("ไม่มีคำร้องที่ดำเนินการอยู่ในขณะนี้ "),
                        const Text("สามารถกดลงทะเบียนคำร้องได้ที่ปุ่ม \‘+\’")
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            List<Widget> containerList = [
              const SizedBox(height: 10),
            ];
            var _request = snapshot.data as List<request>;
            //สร้าง Listview ที่จะมีคำร้องต่างๆ ของ User
            for (request requestItem in _request) {
              Widget container = UserLayout.createRequestBox(requestItem);
              containerList.add(container);
              containerList.add(const SizedBox(height: 10));
            }
            return Scaffold(
              body: Center(
                  child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(10, 25, 10, 0),
                    child: Text(
                      "ประวัติคำร้อง",
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  RawScrollbar(
                    thumbColor: const Color(0xFFBBB9F4),
                    thumbVisibility: true,
                    radius: const Radius.circular(20),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 20),
                    thickness: 5,
                    child: DefaultTextStyle(
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.white,
                            fontSize: 15.0,
                          ),
                      child: SizedBox(
                        height: 552,
                        width: 344,
                        child: ListView.builder(
                          itemCount: containerList.length,
                          itemBuilder: (context, index) {
                            return containerList[index];
                          },
                        ),
                      ),
                    ),
                  )
                ],
              )),
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return UserLayout(
      Body: getBody(),
      currentPage: 2,
    );
  }
}
