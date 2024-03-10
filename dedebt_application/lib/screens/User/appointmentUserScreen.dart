import 'package:flutter/material.dart';
import 'package:dedebt_application/models/assignmentModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class appointmentUserScreen extends StatefulWidget {
  const appointmentUserScreen({super.key});

  @override
  State<appointmentUserScreen> createState() => _appointmentUserScreen();
}

class _appointmentUserScreen extends State<appointmentUserScreen> {
  //Mockup Data
  Assignment userAppointment = Assignment(
    id: "0",
    type: 1,
    title: "การนัดคุยทางโทรศัพท์",
    detail:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas fermentum laoreet magna, mollis euismod dolor auctor eget. Donec sed odio dui. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Sed posuere consectetur est at lobortis. Maecenas vestibulum lacus eget purus euismod scelerisque quam sed diam. Integer posuere erat a ante blandit elementum. Nullam vitae elit libero, a pharetra augue.",
    status: 0,
    taskId: "TaskID",
    startTime: Timestamp.fromDate(DateTime(2023, 2, 27, 13, 0)),
    endTime: Timestamp.fromDate(DateTime(2023, 2, 27, 17, 0)),
  );
  static Color appBarColor = const Color(0xFF444371);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: appBarColor,
          surfaceTintColor: Colors.transparent,
          toolbarHeight: 55,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_back,
                  size: 35,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 65,
              ),
              const Text(
                "นัดหมายเวลา",
                style: TextStyle(fontSize: 24, color: Colors.white),
              )
            ],
          )),
      body: Align(
        alignment: Alignment.center,
        child: DefaultTextStyle(
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: const Color(0xFF000000),
                fontSize: 18.0,
              ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Icon(
                  Icons.access_time,
                  size: 65,
                  color: Color(0xFF36338C),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "ยืนยันวันเวลานัดหมาย",
                  style: TextStyle(fontSize: 24, color: Color(0xFF36338C)),
                )
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 45),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("เวลาที่นัดหมาย"),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    width: 304,
                    height: 46,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          offset: Offset(0.0, 4.0),
                          blurRadius: 4.0,
                          spreadRadius: 1.0,
                        ),
                      ],
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${DateFormat("HH:mm").format(userAppointment.startTime.toDate())} - ${DateFormat("HH:mm").format(userAppointment.endTime.toDate())}",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 45),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("รายละเอียด"),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 25),
                    width: 304,
                    height: 280,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          offset: Offset(0.0, 4.0),
                          blurRadius: 4.0,
                          spreadRadius: 1.0,
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: Text(
                        userAppointment.detail,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
      bottomNavigationBar: Container(
        width: 390,
        height: 165,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        color: Colors.white,
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
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF18F80),
                      ),
                      child: const Text(
                        'ไม่สะดวกวันเวลาที่นัดหมาย',
                        style: TextStyle(fontSize: 18.0, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle button press
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2DC09C),
                      ),
                      child: const Text(
                        'ยืนยันการนัด',
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
      ),
    );
  }
}
