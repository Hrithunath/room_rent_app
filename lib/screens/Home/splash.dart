
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:room_rent_app/screens/Home/home.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigatetologin();
  }

  _navigatetologin() async {
    await Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Home(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
     
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('lib/assets/images/splash.png'),        
          
        ),
      ),
    );
  }
}
