import 'package:dedebt_application/repositories/adminRepository.dart';

class AdminService {
  final AdminRepository adminRepository;

  AdminService({required this.adminRepository});

  Future<List<Map<String, dynamic>>> getAllUsersData() async {
    try {
      return await adminRepository.getAllUsersData();
    } catch (e) {
      // Handle error
      print('Error in Admin Service: $e');
      return [];
    }
  }
}
