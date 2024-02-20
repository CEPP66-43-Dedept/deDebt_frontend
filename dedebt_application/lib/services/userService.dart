// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dedebt_application/repositories/userRepository.dart';

class UserService {
  final UserRepository _userRepository;

  UserService({required UserRepository userRepository})
      : _userRepository = userRepository;

  Future<Map<String, dynamic>?> getUserData(String userId) async {
    try {
      return await _userRepository.getUserData(userId);
    } catch (e) {
      print('Error getting user data: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> getUserActiveRequest(String userId) async {
    try {
      return await _userRepository.getUserActiveRequest(userId);
    } catch (e) {
      print('Error getting user data: $e');
      return null;
    }
  }
}
