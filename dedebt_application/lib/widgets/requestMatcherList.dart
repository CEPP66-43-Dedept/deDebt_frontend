import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dedebt_application/repositories/matcherRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dedebt_application/models/requestModel.dart';
import 'package:dedebt_application/services/matcherService.dart';

class RequestMatcherList extends StatefulWidget {
  const RequestMatcherList({Key? key});

  @override
  State<RequestMatcherList> createState() => _RequestMatcherListState();
}

class _RequestMatcherListState extends State<RequestMatcherList> {
  late final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late final MatcherRepository _matcherRepository =
      MatcherRepository(firestore: firestore);
  late MatcherService _matcherService =
      MatcherService(matcherRepository: _matcherRepository);
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _matcherService = MatcherService(matcherRepository: _matcherRepository);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Request>>(
      stream: _matcherService.getWaitingRequest(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          print("Snap:${snapshot.data}");
          List<Request>? requests = snapshot.data;
          if (requests != null && requests.isNotEmpty) {
            return ListView.builder(
              itemCount: requests.length,
              itemBuilder: (context, index) {
                return createRequestBox(requests[index]);
              },
            );
          } else {
            return Text('No requests found.');
          }
        }
      },
    );
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

  static Container createRequestBox(Request _request) {
    return Container(
      width: 314,
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
                    child: const Text(
                      "นางสมหญิง หญิงมาก",
                      style: TextStyle(color: Color(0xFF2DC09C)),
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
}
