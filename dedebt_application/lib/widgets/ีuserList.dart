import 'package:dedebt_application/variables/color.dart';
import 'package:flutter/material.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  int? _hoveredIndex;
  void ShowUserDetail(int inDexUser) {}

  @override
  Widget build(BuildContext context) {
    final items = List<String>.generate(40, (i) => 'Item $i');

    return ListView.builder(
      itemCount: items.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: ElevatedButton(
            child: Text(
              "$index",
              style: TextStyle(),
            ),
            style: ElevatedButton.styleFrom(
              fixedSize: Size(200, 60),
              backgroundColor: ColorGuide.blueLight,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () {},
          ),
        );
      },
    );
  }
}
