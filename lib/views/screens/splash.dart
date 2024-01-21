import 'package:flutter/material.dart';
import 'package:flutter_fuel_delivery/utils/firebase_utils.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      getScreen().then((value) {
        Get.offAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Align(
        alignment: Alignment.center,
        child: Image.asset(
          'assets/images/pump.jpg',
          width: 140,
          fit: BoxFit.cover,
        ),
      ),
    ));
  }
}
