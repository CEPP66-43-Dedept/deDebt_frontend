import 'package:dedebt_application/models/requestModel.dart';
import 'package:dedebt_application/screens/layouts/advisorLayout.dart';
import 'package:flutter/material.dart';

class historyAdvisorScreen extends StatefulWidget {
  const historyAdvisorScreen({super.key});

  State<historyAdvisorScreen> createState() => _historyAdvisorScreen();
}

class _historyAdvisorScreen extends State<historyAdvisorScreen> {
  static Color primaryColor = const Color(0xFFF3F5FE);
  //Mockup Data
  List<Request> requests = [
    Request(
        id: "xx",
        title: "แก้หนี้",
        detail: "หนี้",
        userId: "xxx",
        advisorId: "advisorId",
        userFullName: " userFullName",
        advisorFullName: " advisorFullName",
        requestStatus: 0,
        type: ["type"],
        debtStatus: [0],
        provider: ["ser"],
        branch: ["sef"],
        revenue: [12345],
        expense: [123],
        burden: 1,
        property: 123,
        appointmentDate: [1])
  ];
  @override
  Widget build(BuildContext context) {
    bool has_request = true;
    // TODO: implement build
    if (!has_request) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('ประวัติคำร้อง'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Image(image: AssetImage('assets/images/Nothing.png')),
              Text('ไม่มีคำร้อง'),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: const Text('ประวัติคำร้อง'),
        ),
        body: RawScrollbar(
          thumbColor: const Color(0xFFBBB9F4),
          thumbVisibility: true,
          radius: const Radius.circular(20),
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
          thickness: 5,
          child: DefaultTextStyle(
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.white,
                  fontSize: 15.0,
                ),
            child: ListView.builder(
              itemCount: requests.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    AdvisorLayout.createRequestBox(context, requests[index]),
                    SizedBox(
                      height: 10,
                    )
                  ],
                );
              },
            ),
          ),
        ),
      );
    }
  }
}
