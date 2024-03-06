import 'package:dedebt_application/models/requestModel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RequestMatcherScreen extends StatefulWidget {
  // Declare userRequest as final
  const RequestMatcherScreen({Key? key})
      : super(key: key); // Correct constructor syntax

  @override
  _RequestMatcherScreenState createState() => _RequestMatcherScreenState();
}

class _RequestMatcherScreenState extends State<RequestMatcherScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("test"),
    );
  }
}
