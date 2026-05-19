import 'package:flutter/material.dart';

class LeftSlideAnimation extends StatelessWidget {
  final Widget child;
  final int delay;

  const LeftSlideAnimation({super.key, required this.child, this.delay = 0});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween(begin: 100.0, end: 0.0),
      duration: Duration(milliseconds: 800 + delay),
      curve: Curves.easeInOut,
      builder: (context, value, childWidget) {
        return Transform.translate(
          offset: Offset(value, 0),
          child: Opacity(
            opacity: (1 - (value.abs() / 100)).clamp(0.0, 1.0),
            child: childWidget,
          ),
        );
      },
      child: child,
    );
  }
}
