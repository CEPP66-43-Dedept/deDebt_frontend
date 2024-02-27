import 'package:dedebt_application/models/advisorModel.dart';
import 'package:dedebt_application/repositories/adminRepository.dart';
import 'package:dedebt_application/variables/rolesEnum.dart';

class AdminService {
  final AdminRepository adminRepository;

  AdminService({required this.adminRepository});

  Future<List<Map<String, dynamic>>> getAllUsersData(int currentIndex) async {
    try {
      return await adminRepository.getAllUsersData(currentIndex);
    } catch (e) {
      print('Error in Admin Service: $e');
      return [];
    }
  }

  Future<Map<String, dynamic>> getUserDataById(String uid, Roles role) async {
    try {
      return await adminRepository.getUserDataById(uid, role);
    } catch (e) {
      print('Error in Admin Service: $e');
      return {};
    }
  }

  Future<void> deleteUserByID(
      {required String uid, required Roles role}) async {
    try {
      await adminRepository.deleteUserByID(uid: uid, role: role);
    } catch (e) {
      print('Error in Admin Service: $e');
    }
  }

  Future<void> createAdvisor({required Advisors advisor}) async {
    try {
      await adminRepository.createAdvisor(advisor: advisor);
    } catch (e) {
      print("fail create");
    }
  }
}
