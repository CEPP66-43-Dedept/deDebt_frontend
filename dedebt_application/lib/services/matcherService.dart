// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dedebt_application/models/advisorModel.dart';
import 'package:dedebt_application/models/requestModel.dart';
import 'package:dedebt_application/repositories/matcherRepository.dart';
import 'package:dedebt_application/repositories/userRepository.dart';

class MatcherService {
  final MatcherRepository _matcherRepository;

  MatcherService({required MatcherRepository matcherRepository})
      : _matcherRepository = matcherRepository;

  Stream<List<Request>> getWaitingRequest() {
    try {
      return _matcherRepository.getWaitingRequest();
    } catch (e) {
      print('Error getting user data: $e');
      throw e;
    }
  }

  Future<Request?> getRequestByrequestID(String userId) async {
    try {
      return await _matcherRepository.getRequestByrequestID(userId);
    } catch (e) {
      print('Error getting user data: $e');
      return null;
    }
  }

  Future<List<Advisors>> getAllAdvisorsData() async {
    try {
      return await _matcherRepository.getAllAdvisorsData();
    } catch (e) {
      print('Error fetching users data: $e');
      return [];
    }
  }

  Future<List<Advisors>> processTimestampData(Timestamp timestamp) async {
    try {
      return await _matcherRepository.processTimestampData(timestamp);
    } catch (e) {
      print('Error fetching users data: $e');
      return [];
    }
  }

  Future<void> matchRequestWithAdvisor(
      Advisors advisors, Request request) async {
    try {
      await _matcherRepository.matchRequestWithAdvisor(advisors, request);
      print('Successfully updated aid in the request document.');
    } catch (e) {
      print('Error updating aid in the request document: $e');
    }
  }
}
