import 'package:flutter/material.dart';
import 'package:dedebt_application/models/userModel.dart';
import 'package:dedebt_application/models/assignmentModel.dart';
import 'package:dedebt_application/screens/layouts/advisorLayout.dart';

class homeAdvisorScreen extends StatefulWidget {
  const homeAdvisorScreen({super.key});
  @override
  State<homeAdvisorScreen> createState() => _homeAdvisorScreen();
}

class _homeAdvisorScreen extends State<homeAdvisorScreen> {
  //Mockup Data
  Users thisAdvisor = Users(
    id: 0,
    ssn: 0,
    firstname: "สมปรึกษา",
    lastname: "ปรึกษาทุกอย่าง",
    roles: "Advisor",
    requests: [0],
    email: "prugsa@mail.com",
    tel: "0123456789",
    password: "SecureP@ssw0rd",
  );
  Assignment userAppointment = Assignment(
      id: 0,
      type: "การนัดหมาย",
      title: "การนัดคุยทางโทรศัพท์",
      detail: "โทรทางมือถือเบอร์ 123-456-7890",
      status: "ดำเนินการ",
      tid: null,
      advisorTimeslot: [],
      userTimeslot: DateTime(2024, 2, 21));

  @override
  Widget build(BuildContext context) {
    var u_assignment = [userAppointment, userAppointment, userAppointment];
    List<Widget> AssignmentContainerList = [
      const SizedBox(height: 5),
    ];
    for (Assignment assign in u_assignment) {
      Widget container = AdvisorLayout.createAssignmentContainer(assign);
      AssignmentContainerList.add(container);
      AssignmentContainerList.add(const SizedBox(height: 10));
    }
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 25, 10, 0),
              child: Text(
                "สวัสดี ${thisAdvisor.firstname}",
                style: const TextStyle(fontSize: 20),
              ),
            ),
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  "งานของคุณวันนี้'",
                  style: TextStyle(fontSize: 24),
                )),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 14),
              child: RawScrollbar(
                thumbColor: const Color(0xFFBBB9F4),
                thumbVisibility: true,
                radius: const Radius.circular(20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 6.0, vertical: 10),
                thickness: 5,
                child: Container(
                  height: 218,
                  width: 324,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: DefaultTextStyle(
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: const Color(0xFF36338C),
                          fontSize: 15.0,
                        ),
                    child: ListView.builder(
                      itemCount: AssignmentContainerList.length,
                      itemBuilder: (context, index) {
                        return AssignmentContainerList[index];
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
