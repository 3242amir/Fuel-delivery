import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/quality_controller.dart';

class SelectQuantity extends StatelessWidget {
  const SelectQuantity({super.key, required this.controller});
  final QualtiyController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: List.generate(
          controller.items.length,
          (index) => Items(
            txt: controller.items[index],
            onPress: () {
              controller.setIndex = index;
            },
            isActive: controller.index == index,
          ),
        ),
      ),
    );
  }
}

class Items extends StatelessWidget {
  const Items({
    super.key,
    required this.txt,
    required this.onPress,
    required this.isActive,
  });
  final String txt;
  final VoidCallback onPress;
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: Get.width,
        height: Get.height * 0.08,
        margin: const EdgeInsets.only(top: 8.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: const Color(0xFFF6F6FB),
          border: Border.all(
            color: isActive ? const Color(0xFFFF681B) : const Color(0xFFF6F6FB),
          ),
        ),
        child: Text(
          txt,
          style: TextStyle(
            fontFamily: 'Oxygen',
            fontSize: 19.0,
            color: isActive ? const Color(0xFFFF681B) : const Color(0xFF1B1B1B),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
