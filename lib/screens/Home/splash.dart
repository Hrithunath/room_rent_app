import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:room_rent_app/screens/Home/home.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Center(
            child: LottieBuilder.asset(
                'lib/lottie/Animation - 1711520002438.json'),
          )
        ],
      ),
      nextScreen: const Home(),
      splashIconSize: 400,
      backgroundColor: Colors.white,
    );
  }
}
