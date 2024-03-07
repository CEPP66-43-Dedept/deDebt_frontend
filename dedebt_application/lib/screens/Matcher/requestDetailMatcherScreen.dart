import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dedebt_application/models/advisorModel.dart';
import 'package:dedebt_application/models/requestModel.dart';
import 'package:dedebt_application/repositories/matcherRepository.dart';
import 'package:dedebt_application/services/matcherService.dart';
import 'package:dedebt_application/variables/color.dart';
import 'package:dedebt_application/widgets/showAdvisorBottomsheet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RequestMatcherScreen extends StatefulWidget {
  final String requestID;

  const RequestMatcherScreen({required this.requestID, Key? key})
      : super(key: key);

  @override
  _RequestMatcherScreenState createState() => _RequestMatcherScreenState();
}

class _RequestMatcherScreenState extends State<RequestMatcherScreen> {
  late final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late final MatcherRepository _matcherRepository =
      MatcherRepository(firestore: firestore);
  late MatcherService _matcherService =
      MatcherService(matcherRepository: _matcherRepository);
  late StreamController<Request?> _requestController;
  bool isExpanded = false;
  @override
  void initState() {
    super.initState();
    _requestController = StreamController<Request?>();
    _getRequestByrequestID(widget.requestID).then((requestData) {
      _requestController.add(requestData);
    }).catchError((error) {
      _requestController.addError(error);
    });
  }

  @override
  void dispose() {
    _requestController.close();
    super.dispose();
  }

  Future<Request?> _getRequestByrequestID(String requestId) async {
    return _matcherService.getRequestByrequestID(requestId);
  }

  Future<List<Advisors>> _getAllAdvisorsData() async {
    try {
      List<Advisors> advisors = await _matcherService.getAllAdvisorsData();
      return advisors;
    } catch (e) {
      print('Error fetching advisors data: $e');
      return [];
    }
  }

  @override
  String getRequestDetailString(Request _request) {
    String returnString = "ขณะนี้เป็นหนี้กับผู้ให้บริการ";
    for (int i = 0; i < _request.provider.length; i++) {
      String debtStatus = "";
      switch (_request.debtStatus[i]) {
        case 0:
          debtStatus = "ปกติหรือค้างชำระไม่เกิน 90 วัน";
          break;
        case 1:
          debtStatus = "Non-performing Loan(NPL)(ค้างชำระไม่เกิน 90 วัน)";
          break;
        case 2:
          debtStatus = "อยู่ระหว่างกระบวนการกฎหมายหรือศาลพิพากษาแล้ว";
          break;
      }
      returnString =
          "$returnString${_request.provider[i]}ที่สาขา${_request.branch[i]}สถานะหนี้ ณ ตอนนี้ $debtStatus,\n";
    }
    returnString += "\n";
    for (int i = 0; i < _request.revenue.length; i++) {
      String revenue = "";

      switch (i) {
        case 0:
          revenue = "รายได้หลักต่อเดือน";
          break;
        case 1:
          revenue = "รายได้เสริม";
          break;
        case 2:
          revenue = "ผลตอบแทนการลงทุน";
          break;
        case 3:
          revenue = "รายได้จากธุรกิจส่วนตัว";
          break;
      }
      returnString = "$returnString $revenue ${_request.revenue[i]} บาท,\n";
    }
    returnString += "\n";
    for (int i = 0; i < _request.expense.length; i++) {
      String expense = "";

      switch (i) {
        case 0:
          expense = "ค่าใช้จ่ายในชีวิตประจำวันต่อเดือน";
          break;
        case 1:
          expense = "ภาระหนี้";
          break;
      }
      returnString = "$returnString $expense ${_request.expense[i]} บาท,\n";
    }
    returnString += "\nสัดส่วนการผ่อนหนี้ต่อรายได้";
    switch (_request.burden) {
      case 0:
        returnString += " : ผ่อนหนี้ 1/3 ของรายได้ต่อเดือน";
        break;
      case 1:
        returnString +=
            " : ผ่อนหนี้มากกว่า 1/3 แต่ยังน้อยกว่า 1/2 ของรายได้ต่อเดือน";
        break;
      case 2:
        returnString +=
            " : ผ่อนหนี้มากกว่า 1/2 รายได้ต่อเดือนแต่น้อยกว่า 2/3 ต่อเดือน";
        break;
      case 3:
        returnString += " : ผ่อนหนี้ 2/3 ของรายได้ต่อเดือน";
        break;
    }
    returnString +=
        "\nทรัพย์สินส่วนตัว ${_request.property} บาท\nรายละเอียดเพิ่มเติม : ${_request.detail}";
    return returnString;
  }

  static Container getRequestStatusContainer(Request _request) {
    Color containerColor;
    bool isCase1 = false;
    switch (_request.requestStatus) {
      case 0:
        containerColor = const Color(0xFFE1E4F8);
        isCase1 = true;
        break;
      case 1:
        containerColor = const Color(0xFFF18F80);
        break;
      case 2:
        containerColor = const Color(0xFF2DC09C);
        break;
      default:
        containerColor = const Color(0xFFFFFFFF);
        break;
    }
    Container statusContainer = Container(
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Text(
        _request.requestStatus == 0
            ? "จัดหาที่ปรึกษา"
            : _request.requestStatus == 1
                ? "กำลังปรึกษา"
                : _request.requestStatus == 2
                    ? "เสร็จสิ้น"
                    : "",
        style: TextStyle(color: isCase1 ? const Color(0xFF7673D3) : null),
      ),
    );
    return statusContainer;
  }

  @override
  static Container createRequestBox(Request _request) {
    return Container(
      width: 324,
      decoration: BoxDecoration(
        color: const Color(0xFF36338C),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: SizedBox(
            width: 310,
            child: Text(_request.title,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 24)),
          ),
        ),
        Column(
          children: [
            Row(
              children: [
                const Text("สถานะ : "),
                //สถานะ container
                getRequestStatusContainer(_request),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Text("ผู้รับผิดชอบ : "),
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F4FD),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      _request.advisorFullName,
                      style: const TextStyle(color: Color(0xFF2DC09C)),
                      softWrap: true,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Text("ประเภท : "),
                SizedBox(
                  width: 200,
                  child: Text(
                    _request.type.join(","),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Text("รายละเอียด : "),
                SizedBox(
                  width: 200,
                  child: Text(
                    _request.detail,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ]),
    );
  }

  @override
  ScrollController _scrollController = ScrollController();
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<Request?>(
        stream: _requestController.stream,
        builder: (context, requestSnapshot) {
          if (requestSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (requestSnapshot.hasError || !requestSnapshot.hasData) {
            return Center(child: Text('Error fetching data'));
          } else {
            final request = requestSnapshot.data!;
            return Container(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(90, 25, 10, 0),
                        child: Text(
                          "คำร้องปัจจุบัน",
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                      SizedBox(
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF36338C),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          width: 324,
                          padding: const EdgeInsets.all(16.0),
                          margin: const EdgeInsets.symmetric(vertical: 16.0),
                          child: DefaultTextStyle(
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: Colors.white,
                                  fontSize: 15.0,
                                ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: SizedBox(
                                    width: 310,
                                    child: Text(
                                      request.title,
                                      style: const TextStyle(fontSize: 24),
                                      overflow: isExpanded
                                          ? TextOverflow.visible
                                          : TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        getRequestStatusContainer(request),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        const Text("ผู้รับผิดชอบ : "),
                                        Flexible(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFF0F4FD),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0),
                                            child: Text(
                                              request.advisorFullName,
                                              style: const TextStyle(
                                                  color: Color(0xFF2DC09C)),
                                              softWrap: true,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text("ประเภท : "),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                request.type.join(","),
                                                overflow: isExpanded
                                                    ? TextOverflow.visible
                                                    : TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text("รายละเอียด : "),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                getRequestDetailString(request),
                                                overflow: isExpanded
                                                    ? TextOverflow.visible
                                                    : TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                      visualDensity: VisualDensity(
                                          horizontal: -4, vertical: -4),
                                      icon: Icon(
                                        isExpanded
                                            ? Icons.keyboard_arrow_up
                                            : Icons.keyboard_arrow_down,
                                        size: 42,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        print(getRequestDetailString(request));
                                        setState(() {
                                          isExpanded = !isExpanded;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                            (states) => ColorGuide.greenAccent,
                          ),
                          fixedSize: MaterialStateProperty.all(Size(325, 50)),
                        ),
                        onPressed: () async {
                          try {
                            List<Advisors> advisors =
                                await _getAllAdvisorsData();
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (context) => AdvisorlistBottomSheet(
                                advisors: advisors,
                                currentRequest: request,
                              ),
                            );
                          } catch (e) {
                            print('Error fetching advisors data: $e');
                            // Handle error gracefully, e.g., show a snackbar or error message
                          }
                        },
                        child: Text(
                          "จับคู่ที่ปรึกษา",
                          style:
                              TextStyle(color: ColorGuide.white, fontSize: 20),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Color _getRequestStatusColor(int status) {
    switch (status) {
      case 0:
        return const Color(0xFFE1E4F8);
      case 1:
        return const Color(0xFFF18F80);
      case 2:
        return const Color(0xFF2DC09C);
      default:
        return Colors.white;
    }
  }
}
