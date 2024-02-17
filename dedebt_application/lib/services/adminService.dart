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
}
