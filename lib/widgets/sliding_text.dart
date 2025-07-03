import 'package:flutter/material.dart';

class SlidingText extends StatelessWidget {
  final Animation<Offset> slidingAnimatin;
  final AnimationController controller;

  const SlidingText({
    super.key,
    required this.slidingAnimatin,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: controller.drive(
        Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: Curves.easeIn)),
      ),
      child: ScaleTransition(
        scale: controller.drive(
          Tween(begin: 0.8, end: 1.0).chain(CurveTween(curve: Curves.easeOutBack)),
        ),
        child: SlideTransition(
          position: slidingAnimatin,
          child: const Text(
            'Scholar Chat',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontFamily: 'Pacifico',
            ),
          ),
        ),
      ),
    );
  }
}
