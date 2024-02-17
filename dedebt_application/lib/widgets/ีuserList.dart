import 'package:dedebt_application/variables/color.dart';
import 'package:flutter/material.dart';

class UserList extends StatelessWidget {
  final List<Map<String, dynamic>> usersData;

  const UserList({required this.usersData, Key? key}) : super(key: key);

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
            onPressed: () {},
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
