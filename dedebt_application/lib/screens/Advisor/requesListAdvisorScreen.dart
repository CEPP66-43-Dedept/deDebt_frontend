import 'package:flutter/material.dart';
import 'package:dedebt_application/screens/layouts/advisorLayout.dart';
import 'package:dedebt_application/models/requestModel.dart';

class requestListAdvisorScreen extends StatefulWidget {
  const requestListAdvisorScreen({super.key});
  @override
  State<requestListAdvisorScreen> createState() => _requestListAdvisorScreen();
}

class _requestListAdvisorScreen extends State<requestListAdvisorScreen> {
  //Mockup Data
  request userrequest = request(
      id: 0,
      title: "การแก้หนี้กับธนาคารกสิกรไทย",
      detail:
          "123456แก้หนี้ที่ค้างคามานานมากมายแก้หนี้ที่ค้างคามานานมากมายแก้หนี้ที่ค้างคามานานมากมาย1234567890แก้หนี้ที่ค้างคามานานมากมายแก้หนี้ที่ค้างคามานานมากมายแก้หนี้ที่ค้างคามานานมากมาย1234567890แก้หนี้ที่ค้างคามานานมากมายแก้หนี้ที่ค้างคามานานมากมายแก้หนี้ที่ค้างคามานานมากมาย1234567890",
      userId: 0,
      advisorId: 0,
      advisorFullName: "นายสมปอง งอปมส",
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
  dynamic getBody() {
    bool isHavedata = false;
    if (isHavedata) {
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
                  const Text("ไม่มีคำร้อง"),
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

      List<request> _request = [
        userrequest,
        userrequest,
        userrequest,
        userrequest
      ];
      //สร้าง Listview ที่จะมีคำร้องต่างๆ ของ User
      for (request requestItem in _request) {
        Widget container = AdvisorLayout.createRequestBox(requestItem);
        containerList.add(container);
        containerList.add(const SizedBox(height: 10));
      }
      return Scaffold(
        body: Center(
            child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 25, 10, 20),
              child: Text(
                "คำร้องปัจจุบัน",
                style: TextStyle(fontSize: 24),
              ),
            ),
            RawScrollbar(
              thumbColor: const Color(0xFFBBB9F4),
              thumbVisibility: true,
              radius: const Radius.circular(20),
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
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
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: getBody(),
    );
  }
}
