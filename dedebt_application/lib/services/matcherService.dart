// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
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
}