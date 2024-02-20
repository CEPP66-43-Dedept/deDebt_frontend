import 'package:dedebt_application/repositories/adminRepository.dart';
import 'package:dedebt_application/services/adminService.dart';
import 'package:dedebt_application/variables/color.dart';
import 'package:dedebt_application/variables/rolesEnum.dart';
import 'package:dedebt_application/widgets/deleteUserBottomsheet.dart';
import 'package:flutter/material.dart';

class UserList extends StatelessWidget {
  final List<Map<String, dynamic>> usersData;

  const UserList(
      {required this.usersData,
      required this.adminRepository,
      required this.adminService,
      required this.role,
      Key? key})
      : super(key: key);
  final AdminRepository adminRepository;
  final AdminService adminService;
  final Roles role;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: usersData.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(200, 60),
              backgroundColor: ColorGuide.blueLight,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return DeleteUserBottomsheet(
                    adminRepository: adminRepository,
                    adminService: adminService,
                    index: index,
                    uid: usersData[index]['uid'],
                    role: role,
                  );
                },
              );
            },
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "${usersData[index]['firstName']} ${usersData[index]['lastName']}",
                style:
                    const TextStyle(fontSize: 18, color: ColorGuide.blueAccent),
              ),
            ),
          ),
        );
      },
    );
  }
}
