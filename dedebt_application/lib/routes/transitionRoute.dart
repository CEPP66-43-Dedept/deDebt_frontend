import 'package:dedebt_application/screens/layouts/userLayout.dart';
import 'package:flutter/material.dart';

class TransitionRoutePage extends StatefulWidget {
  final Widget child;
  const TransitionRoutePage({required this.child});
  @override
  _TransitionRoutePageState createState() => _TransitionRoutePageState();
}

class _TransitionRoutePageState extends State<TransitionRoutePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCirc,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: CurveTween(curve: Curves.easeInOutCirc).animate(_animation),
      child: widget.child,
    );
  }
}

class TransitionRoute extends PageRouteBuilder {
  final Widget page;

  TransitionRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (
            context,
            animation,
            secondaryAnimation,
            child,
          ) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
}
