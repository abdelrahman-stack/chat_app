import 'package:flutter/material.dart';
import 'package:scholar_app/constants.dart';
import 'package:scholar_app/widgets/splash_view_body.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor:kPraimaryColor,
      body: SplashViewBody());
  }
}
