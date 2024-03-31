import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dedebt_application/repositories/advisorRepository.dart';
import 'package:dedebt_application/services/advisorService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dedebt_application/screens/layouts/advisorLayout.dart';
import 'package:dedebt_application/models/requestModel.dart';

class requestListAdvisorScreen extends StatefulWidget {
  const requestListAdvisorScreen({Key? key});
  @override
  State<requestListAdvisorScreen> createState() =>
      _requestListAdvisorScreenState();
}

class _requestListAdvisorScreenState extends State<requestListAdvisorScreen> {
  //Mockup Data
  static Color primaryColor = const Color(0xFFF3F5FE);
  late final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late final AdvisorRepository _advisorRepository =
      AdvisorRepository(firestore: firestore);
  late final AdvisorService _advisorService =
      AdvisorService(advisorRepository: _advisorRepository);
  late StreamController<List<Request>> _advisorRequestController;
  late User? user = FirebaseAuth.instance.currentUser;
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    _advisorRequestController = StreamController<List<Request>>();
    _getAdvisorActiveRequests(user!.uid).then((requestData) {
      _advisorRequestController.add(requestData!);
    }).catchError((error) {
      print('Error fetching user requests: $error');
      _advisorRequestController.addError(error);
    });
  }

  @override
  void dispose() {
    _advisorRequestController.close();
    super.dispose();
  }

  Future<List<Request>?> _getAdvisorActiveRequests(String userId) async {
    return _advisorService.getAdvisorActiveRequest(userId);
  }

  Future<String?> _getUserName(String userId) async {
    return _advisorService.getUserFullnameByID(userId);
  }

  Widget _buildRequestBox(Request request, String userFullName) {
    return AdvisorLayout.createRequestBox(context, request, userFullName);
  }

  Widget _buildLoadingIndicator() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildErrorText(String errorMessage) {
    return Center(child: Text('Error: $errorMessage'));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Request>>(
      stream: _advisorRequestController.stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingIndicator();
        } else if (snapshot.hasError || !snapshot.hasData) {
          return _buildErrorText('Error fetching data');
        }
        List<Request>? requests = snapshot.data;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            title: Center(child: const Text('คำร้องปัจจุบัน')),
          ),
          body: _buildBody(requests),
        );
      },
    );
  }

  Widget _buildBody(List<Request>? requests) {
    if (requests == null || requests.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Image(image: AssetImage('assets/images/Nothing.png')),
            Text('ไม่มีคำร้อง'),
          ],
        ),
      );
    } else {
      return _buildRequestListView(requests);
    }
  }

  Widget _buildRequestListView(List<Request> requests) {
    return RawScrollbar(
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
                FutureBuilder<String?>(
                  future: _getUserName(requests[index].userId),
                  builder: (context, userSnapshot) {
                    if (userSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return _buildLoadingIndicator();
                    } else if (userSnapshot.hasError) {
                      return _buildErrorText('Error fetching user name');
                    }
                    final userFullName = userSnapshot.data ?? 'สมศรี มีดี';
                    return _buildRequestBox(requests[index], userFullName);
                  },
                ),
                const SizedBox(height: 10),
              ],
            );
          },
        ),
      ),
    );
  }
}
