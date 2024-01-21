import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/circle_painter.dart';
import 'home/home.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFEFEFE),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/car.png',
                  fit: BoxFit.cover,
                  height: Get.height * 0.5,
                  width: double.infinity,
                ),
                SizedBox(height: Get.height * 0.01),
                const Text.rich(
                  TextSpan(
                    text: "Fuel ",
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Color(0xFF040404),
                      fontWeight: FontWeight.w600,
                    ),
                    children: [
                      TextSpan(
                        text: "Anytime",
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Color(0xFFFF681B),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Get.height * 0.02),
                const Text(
                  "Discover the convenience of on-demand fuel delivery with our user-friendly app. Order fuel whenever and wherever you need it, and enjoy the freedom to focus on what truly matters.Revolutionize your refueling experience with our cutting-edge fuel delivery app. Enjoy seamless transactions, timely deliveries, and the convenience of managing your fuel needs at your fingertips.",
                  style: TextStyle(
                    color: Color(0xFFB8B6B6),
                    fontSize: 17.0,
                    fontFamily: "Oxygen",
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 10,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: Get.height * 0.03),
                GestureDetector(
                  onTap: () {
                    Get.to(const Home());
                  },
                  child: Container(
                    height: 55,
                    width: 55,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFF681B),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 160, 160, 160),
                          blurRadius: 3,
                          spreadRadius: 0.3,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        alignment: Alignment.center,
                        clipBehavior: Clip.none,
                        children: const [
                          CustomPaint(
                            size: Size(40, 40),
                            painter: CirclePainter(Color(0xFFFFFFFF), 1.0),
                          ),
                          Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
