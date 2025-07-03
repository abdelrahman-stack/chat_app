import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:scholar_app/core/utils/app_router.dart';
import 'package:scholar_app/widgets/sliding_text.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slidingAnimatin;

  @override
  void initState() {
    super.initState();
    initSlidingAnimation();
    navigatorToHome();
  }

  void navigatorToHome() {
    Future.delayed(const Duration(seconds: 3), () {
      GoRouter.of(context).push(AppRouter.kLoginView);
    });
  }

  void initSlidingAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    slidingAnimatin = Tween<Offset>(
      begin: const Offset(0, 8),
      end: Offset.zero,
    ).animate(animationController);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      animationController.forward();
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset('assets/images/scholar.png', height: 100),
        const SizedBox(height: 4),
        SlidingText(
  slidingAnimatin: slidingAnimatin,
  controller: animationController,
),

      ],
    );
  }
}
