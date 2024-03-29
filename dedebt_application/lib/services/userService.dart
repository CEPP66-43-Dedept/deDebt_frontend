// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dedebt_application/models/assignmentModel.dart';
import 'package:dedebt_application/models/requestModel.dart';
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

  Future<Request?> getRequestByrequestID(String requestID) async {
    try {
      return await _userRepository.getRequestByrequestID(requestID);
    } catch (e) {
      print('Error getting user data: $e');
      return null;
    }
  }

  Future<void> UpdateUserRequest(String requestId) async {
    try {
      await _userRepository.UpdateUserRequest(requestId);
    } catch (e) {
      print('Error getting user data: $e');
    }
  }

  Future<void> updateAssignmentStatus(String assignmentID) async {
    try {
      await _userRepository.updateAssignmentByID(assignmentID);
    } catch (e) {
      print('Error getting user data: $e');
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

  Future<List<Assignment>> getActiveAssignments(String taskId) async {
    try {
      return await _userRepository.getActiveAssignments(taskId);
    } catch (e) {
      print('Error getting user data: $e');
      return [];
    }
  }

  Future<void> createRequest(Request request) async {
    try {
      await _userRepository.createRequest(request);
    } catch (e) {
      print('Error create request data: $e');
    }
  }

  Future<void> getAssignmentById(String taskId) async {
    try {
      await _userRepository.getAssignmentByID(taskId);
    } catch (e) {
      print('Error getting user data: $e');
    }
  }

  Future<List<Assignment>> getAllAssignments(String taskId) async {
    try {
      return await _userRepository.getAllAssignments(taskId);
    } catch (e) {
      print('Error getting user data: $e');
      return [];
    }
  }

  Future<List<Request>?> getUserAllRequests(String userId) async {
    try {
      return await _userRepository.getUserAllRequests(userId);
    } catch (e) {
      print('Error getting user all request: $e');
      return [];
    }
  }

  Future<String?> getFullName(String userId) async {
    try {
      Map<String, dynamic>? userData =
          await _userRepository.getUserData(userId);
      if (userData != null) {
        String? lastName = userData['lastName'];
        String? firstName = userData['firstName'];
        if (lastName != null && firstName != null) {
          String fullName = '$lastName $firstName';
          return fullName;
        }
      }
      return null;
    } catch (e) {
      print('Error getting user data: $e');
      return null;
    }
  }

  Future<Assignment?> getAssignmentByID(String assignmentID) async {
    try {
      return await _userRepository.getAssignmentByID(assignmentID);
    } catch (e) {
      print('Error getting user all request: $e');
      return null;
    }
  }
}
