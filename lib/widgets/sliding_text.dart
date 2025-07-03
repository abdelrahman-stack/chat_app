import 'package:flutter/material.dart';

class SlidingText extends StatelessWidget {
  const SlidingText({super.key, required this.slidingAnimatin});

  final Animation<Offset> slidingAnimatin;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: slidingAnimatin,
      builder: (context, _) {
        return SlideTransition(
          position: slidingAnimatin,
          child: const Text(
            'Scholar Chat',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontFamily: 'Pacifico',
            ),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }
}
