// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dedebt_application/models/advisorModel.dart';
import 'package:dedebt_application/models/assignmentModel.dart';
import 'package:dedebt_application/models/requestModel.dart';
import 'package:dedebt_application/repositories/advisorRepository.dart';
import 'package:dedebt_application/repositories/userRepository.dart';

class AdvisorService {
  final AdvisorRepository _advisorRepository;

  AdvisorService({required AdvisorRepository advisorRepository})
      : _advisorRepository = advisorRepository;

  Future<Advisors?> getAdvisorData(String advisorId) async {
    try {
      return await _advisorRepository.getAdvisorData(advisorId);
    } catch (e) {
      print('Error getting advisor data: $e');
      return null;
    }
  }

  Future<List<Request>?> getAdvisorAllRequests(String advisorId) async {
    try {
      return await _advisorRepository.getAdvisorAllRequests(advisorId);
    } catch (e) {
      print('Error getting user  request: $e');
      return null;
    }
  }

  Future<List<Request>?> getAdvisorActiveRequest(String advisorId) async {
    try {
      return await _advisorRepository.getAdvisorActiveRequest(advisorId);
    } catch (e) {
      print('Error getting user  request: $e');
      return null;
    }
  }

  Future<Request?> getRequestByrequestID(String requestID) async {
    try {
      return await _advisorRepository.getRequestByrequestID(requestID);
    } catch (e) {
      print('Error getting user  request: $e');
      return null;
    }
  }

  Future<void> createAssignment(Assignment assignment) async {
    try {
      await _advisorRepository.createAssignment(assignment);
    } catch (e) {
      print('Error creating assignment: $e');
    }
  }

  Future<String?> getUserFullnameByID(String userId) async {
    try {
      return await _advisorRepository.getUserFullnameByID(userId);
    } catch (e) {
      print('Error getting user data: $e');
      return null;
    }
  }

  Future<List<String>> getAdvisorAllRequestsIds(String advisorId) async {
    try {
      return await _advisorRepository.getAdvisorAllRequestsIds(advisorId);
    } catch (e) {
      print('Error getting user  request: $e');
      return [];
    }
  }

  Future<List<Assignment>> getAssignmentByDay(Timestamp day) async {
    try {
      List<String> requestList = await getAdvisorAllRequestsIds('advisorId');
      return await _advisorRepository.getAssignmentByDay(requestList, day);
    } catch (e) {
      print('Error getting user data: $e');
      return [];
    }
  }

  Future<List<Assignment>> getAllAssignments(String taskId) async {
    try {
      return await _advisorRepository.getAllAssignments(taskId);
    } catch (e) {
      print('Error getting user data: $e');
      return [];
    }
  }

  Future<Assignment?> getAssignmentByID(String assignmentID) async {
    try {
      return await _advisorRepository.getAssignmentByID(assignmentID);
    } catch (e) {
      print('Error getting user all request: $e');
      return null;
    }
  }
}
