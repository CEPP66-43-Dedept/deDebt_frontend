import 'package:dedebt_application/models/advisorModel.dart';
import 'package:dedebt_application/repositories/adminRepository.dart';

class AdminService {
  final AdminRepository adminRepository;

  AdminService({required this.adminRepository});

  Future<List<Map<String, dynamic>>> getAllUsersData(int currentIndex) async {
    try {
      return await adminRepository.getAllUsersData(currentIndex);
    } catch (e) {
      // Handle error
      print('Error in Admin Service: $e');
      return [];
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
