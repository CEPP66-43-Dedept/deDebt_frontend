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

  dynamic getBody() {
    bool isHavedata = false;
    List<Widget> containerList = [
      const SizedBox(height: 10),
    ];

    List<Request> _request = [];
    //สร้าง Listview ที่จะมีคำร้องต่างๆ ของ User
    for (Request requestItem in _request) {
      Widget container = AdvisorLayout.createRequestBox(context, requestItem);
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
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }
}
