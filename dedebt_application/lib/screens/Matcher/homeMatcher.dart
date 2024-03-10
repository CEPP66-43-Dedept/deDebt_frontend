import 'package:dedebt_application/widgets/requestMatcherList.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomeMatcher extends StatefulWidget {
  const HomeMatcher({super.key});

  @override
  State<HomeMatcher> createState() => _HomeMatcherState();
}

class _HomeMatcherState extends State<HomeMatcher> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Text(
          "คำร้องที่ยังไม่ดำเนินการ",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: 20,
        ),
        Scrollbar(
          child:
              Container(width: 400, height: 500, child: RequestMatcherList()),
        )
      ],
    ));
  }
}
