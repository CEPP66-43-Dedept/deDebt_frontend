import 'package:dedebt_application/variables/color.dart';
import 'package:flutter/material.dart';

class CreateAdvisorBottomSheet extends StatelessWidget {
  const CreateAdvisorBottomSheet({required this.context, Key? key})
      : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
              decoration: BoxDecoration(color: ColorGuide.blueAccent),
            );
          },
        );
      },
      child: Text('Open Bottom Sheet'),
    );
  }
}
