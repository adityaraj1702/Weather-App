import 'package:flutter/material.dart';
import 'package:weather_app/utlis/colors.dart';
import 'package:weather_app/utlis/constants.dart';
import 'package:weather_app/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [splash_bgColortop, splash_bgColorbottom],
          ),
        ),
        child: Center(
          child: Image.asset(
            applogo,
            width: 150,
            height: 150,
          ),
        ),
      ),
    );
  }
}
