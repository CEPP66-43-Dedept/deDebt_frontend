import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dedebt_application/models/assignmentModel.dart';
import 'package:dedebt_application/repositories/advisorRepository.dart';
import 'package:dedebt_application/services/advisorService.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:go_router/go_router.dart';
import 'package:dedebt_application/routes/route.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class addAssignmentAdvisorScreen extends StatefulWidget {
  final String requestID;
  const addAssignmentAdvisorScreen({super.key, required this.requestID});
  State<addAssignmentAdvisorScreen> createState() =>
      _addAssignmentAdvisorScreen();
}

class _addAssignmentAdvisorScreen extends State<addAssignmentAdvisorScreen> {
  static Color primaryColor = const Color(0xFFF3F5FE);
  late final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late final AdvisorRepository _advisorRepository =
      AdvisorRepository(firestore: firestore);
  late final AdvisorService _advisorService =
      AdvisorService(advisorRepository: _advisorRepository);

  static Color appBarColor = const Color(0xFF444371);
  static Color navBarColor = const Color(0xFF2DC09C);
  final assignmentTypeController = SingleValueDropDownController();
  final titleController = TextEditingController();
  final detailController = TextEditingController();
  final timeSelectController = TextEditingController();
  final templateSelectorController = TextEditingController();
  final dateSelectorController = TextEditingController();
  final timeSelectorController = TextEditingController();
  final hourSelectorController = SingleValueDropDownController();
  DateTime? pickedDate;
  TimeOfDay? pickedTime;
  List<Widget> containerList = [
    const Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Text("ประเภท"),
    ),
  ];

  static List<DropDownValueModel> assignmentTypeList = [
    DropDownValueModel(name: "กรอกเอกสาร", value: 0),
    DropDownValueModel(name: "นัดหมาย", value: 1)
  ];
  Future<void> _createAssignment() async {
    Assignment assignment = Assignment(
      id: "",
      type: getAssignmentType(),
      title: getAssignmentTitle(),
      detail: getAssignmentdetail(),
      status: 1,
      taskId: widget.requestID,
      startTime: getstartTime(),
      endTime: getendTime(),
    );
    await _advisorService.createAssignment(assignment);
  }

  void initState() {
    super.initState();
    containerList.add(Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: DropDownTextField(
        controller: assignmentTypeController,
        dropDownItemCount: 2,
        dropDownList: assignmentTypeList,
        onChanged: (value) {
          try {
            value = value.value;
          } catch (e) {
            value = "";
          }
          if (value == 1) {
            if (containerList.length > 5) {
              containerList.removeLast();
            }
            containerList.add(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text("เลือกวันนัดหมาย"),
                  ),
                  Container(
                    width: 330,
                    height: 52,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: InkWell(
                      onTap: () {
                        showSelectAppointmentDate();
                      },
                      child: TextFormField(
                        style: TextStyle(color: Colors.black),
                        enabled: false,
                        controller: timeSelectController,
                      ),
                    ),
                  ),
                ],
              ),
            );

            setState(() {});
          } else if (value == 0) {
            if (containerList.length > 5) {
              containerList.removeLast();
            }
            containerList.add(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text("เลือกเทมเพลต"),
                  ),
                  Container(
                    width: 330,
                    height: 52,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: InkWell(
                      onTap: () => showSelectTemplate(),
                      child: TextFormField(
                        enabled: false,
                        style: TextStyle(color: Colors.black),
                        controller: templateSelectorController,
                      ),
                    ),
                  ),
                ],
              ),
            );
            setState(() {});
          } else {
            containerList.removeLast();
            setState(() {});
          }
        },
      ),
    ));
    containerList.add(
      createTextField("หัวข้องาน", false, titleController),
    );
    containerList.add(const Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Text("รายการสิ่งที่ต้องทำ"),
    ));
    containerList.add(
      Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextFormField(
          maxLines: 6,
          maxLength: 300,
          controller: detailController,
          validator: (value) {
            if (value!.isEmpty) {
              return "Please enter Detail";
            }
            return null;
          },
        ),
      ),
    );
  }

  void showSelectTemplate() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 22),
                    child: Text(
                      "เลือกเทมเพลต",
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  getSelectTemplateContainer("เอกสารหักเงินของธนาคารกสิกร"),
                  getSelectTemplateContainer("เอกสารหักเงินของธนาคารกสิกร"),
                  getSelectTemplateContainer("เอกสารหักเงินของธนาคารกสิกร"),
                  getSelectTemplateContainer("เอกสารหักเงินของธนาคารกสิกร"),
                  getSelectTemplateContainer("เอกสารหักเงินของธนาคารกสิกร"),
                  getSelectTemplateContainer("เอกสารหักเงินของธนาคารกสิกร"),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void showPDFViewer() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 22),
                    child: Text(
                      "เลือกเทมเพลต",
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  Container(
                    width: 331,
                    height: 71,
                    child: const Row(
                      children: [
                        Icon(
                          Icons.account_balance,
                          size: 55,
                          color: Colors.black,
                        ),
                        Flexible(
                          child: Text(
                            "ใบหักเงินในบัญชีธนาคารกสิกรไทย",
                            overflow: TextOverflow.visible,
                            style: TextStyle(
                                fontSize: 24, color: Color(0xFF36338C)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 280,
                    height: 280,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(28.0)),
                      color: Color(0xFFDAEAFA),
                    ),
                    padding: const EdgeInsets.fromLTRB(19, 11, 18, 35),
                    child: Stack(
                      children: [
                        Container(
                          width: 302,
                          height: 328,
                          decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            color: Colors.white,
                          ),
                          child: Text("PDF To shown"),
                        ),
                        Positioned(
                          bottom: 1.0,
                          right: 1.0,
                          child: IconButton(
                            icon: Icon(
                              Icons.zoom_out_map,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              // ปุ่มดู pdf
                              print('Info button pressed!');
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 325,
                    height: 62,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      color: Color(0xFF2DC09C),
                    ),
                    child: InkWell(
                        onTap: () {
                          //เพิ่ม template
                          templateSelectorController.text =
                              "ใบหักเงินในบัญชีธนาคารกสิกรไทย";
                          setState(() {});
                          context.pop();
                          context.pop();
                        },
                        child: Center(
                          child: Text(
                            "เพิ่มเทมเพลต",
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                        )),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void showSelectAppointmentDate() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 22),
                    child: Text(
                      "เลือกวันเวลาที่สะดวกนัดหมาย",
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      "เลือกวัน",
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  Container(
                    width: 330,
                    height: 52,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: InkWell(
                      onTap: () async {
                        pickedDate = await showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(Duration(days: 365)));
                        if (pickedDate != null) {
                          dateSelectorController.text =
                              DateFormat('dd-MM-yyyy').format(pickedDate!);
                        }
                      },
                      child: TextFormField(
                        enabled: false,
                        controller: dateSelectorController,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          hintText: 'เลือกวัน', // Your hint text
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      "เลือกเวลา",
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  Container(
                    width: 330,
                    height: 52,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: InkWell(
                      onTap: () async {
                        pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                          initialEntryMode: TimePickerEntryMode.inputOnly,
                          builder: (BuildContext context, Widget? child) {
                            return MediaQuery(
                              data: MediaQuery.of(context)
                                  .copyWith(alwaysUse24HourFormat: true),
                              child: child!,
                            );
                          },
                        );
                        if (pickedTime != null) {
                          timeSelectorController.text =
                              "${pickedTime!.hour}:${pickedTime!.minute}";
                        }
                      },
                      child: TextFormField(
                        enabled: false,
                        controller: timeSelectorController,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          hintText: 'เลือกวัน', // Your hint text
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      "เลือกจำนวนชั่วโมง",
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  Container(
                    width: 330,
                    height: 52,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: DropDownTextField(
                      dropDownList: [1, 2, 3, 4, 5, 6]
                          .map((value) => DropDownValueModel(
                              name: value.toString(), value: value))
                          .toList(),
                      controller: hourSelectorController,
                    ),
                  ),
                  Container(
                    width: 325,
                    height: 62,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      color: Color(0xFF2DC09C),
                    ),
                    child: InkWell(
                        onTap: () {
                          //เพิ่มวันนัดหมาย function
                          if (pickedDate != null && pickedTime != null) {
                            timeSelectController.text =
                                "วันที่ ${DateFormat('dd-MM-yyyy').format(pickedDate!)} เวลา ${pickedTime!.hour}:${pickedTime!.minute}-${pickedTime!.hour + hourSelectorController.dropDownValue!.value}:${pickedTime!.minute}";
                            print(timeSelectController.text);
                            setState(() {});
                            context.pop();
                          } else {
                            context.pop();
                          }
                        },
                        child: Center(
                          child: Text(
                            "เพิ่มวันนัดหมาย",
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                        )),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  InkWell getSelectTemplateContainer(String t_name) {
    return InkWell(
      onTap: () {
        showPDFViewer();
      },
      child: Container(
        width: 325,
        height: 62,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Color(0xFFDAEAFA),
        ),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            Flexible(
              child: Text(t_name,
                  style:
                      const TextStyle(fontSize: 24, color: Color(0xFF36338C)),
                  overflow: TextOverflow.ellipsis),
            ),
            const Icon(Icons.chevron_right, size: 35, color: Color(0xFF36338C))
          ],
        ),
      ),
    );
  }

  Container createTextField(
      String TextBanner, bool isNumberOnly, TextEditingController controller) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(TextBanner),
          ),
          Container(
            width: 330,
            height: 52,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              controller: controller,
              keyboardType:
                  isNumberOnly ? TextInputType.number : TextInputType.text,
              decoration: const InputDecoration(
                hintText: "Type your info Here",
              ),
            ),
          ),
        ],
      ),
    );
  }

  Timestamp getstartTime() {
    if (pickedDate == null || pickedTime == null) {
      return Timestamp.fromDate(DateTime.now());
    }
    return Timestamp.fromDate(DateTime(pickedDate!.year, pickedDate!.month,
        pickedDate!.day, pickedTime!.hour, pickedTime!.minute));
  }

  Timestamp getendTime() {
    if (pickedDate == null || pickedTime == null) {
      return Timestamp.fromDate(DateTime.now());
    }
    return Timestamp.fromDate(DateTime(
        pickedDate!.year,
        pickedDate!.month,
        pickedDate!.day,
        pickedTime!.hour +
            int.parse(hourSelectorController.dropDownValue!.value.toString()),
        pickedTime!.minute));
  }

  int getAssignmentType() {
    return assignmentTypeController.dropDownValue!.value;
  }

  String getAssignmentTitle() {
    return titleController.text;
  }

  String getAssignmentdetail() {
    return detailController.text;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: appBarColor,
            surfaceTintColor: Colors.transparent,
            toolbarHeight: 55,
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    context
                        .go(AppRoutes.REQUEST_ADVISOR + '/' + widget.requestID);
                    //Icon function
                  },
                  icon: const Icon(
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
        body: Align(
          alignment: Alignment.center,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            width: 330,
            height: 690,
            child: SingleChildScrollView(
              child: DefaultTextStyle(
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: const Color(0xFF000000),
                      fontSize: 18.0,
                    ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: containerList),
              ),
            ),
          ),
        ),
        bottomNavigationBar: InkWell(
          onTap: () {
            // function ในการดึงข้อมูล
            _createAssignment();
            context.go(AppRoutes.ADD_ASSIGNMENT_SUCCESS_ADVISOR +
                '/' +
                widget.requestID);
          },
          child: BottomAppBar(
            color: navBarColor,
            height: 104,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    'เพิ่มสิ่งที่ต้องทำ',
                    style: const TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DatePickerItem extends StatelessWidget {
  const _DatePickerItem({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: CupertinoColors.inactiveGray,
            width: 0.0,
          ),
          bottom: BorderSide(
            color: CupertinoColors.inactiveGray,
            width: 0.0,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: children,
        ),
      ),
    );
  }
}
