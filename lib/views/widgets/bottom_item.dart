import 'package:flutter/material.dart';
import 'package:flutter_fuel_delivery/controllers/home_controller.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class BottomItem extends StatelessWidget {
  const BottomItem({super.key, required this.controller});
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      color: Colors.white,
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            controller.items.length,
            (index) => Items(
                path: controller.items[index],
                isActive: index == controller.index,
                onPress: () {
                  controller.setIndex = index;
                }),
          ),
        ),
      ),
    );
  }
}

class Items extends StatelessWidget {
  const Items({
    super.key,
    required this.path,
    required this.isActive,
    required this.onPress,
  });
  final String path;
  final bool isActive;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: SizedBox(
        height: 40.0,
        width: 40.0,
        child: Stack(
          alignment: Alignment.center,
          children: [
            isActive
                ? Container(
                    height: 38.0,
                    width: 38.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFF5F5F5),
                    ),
                  )
                : const SizedBox.shrink(),
            SvgPicture.asset(
              path,
              width: 28,
              height: 28,
              colorFilter: isActive
                  ? const ColorFilter.mode(Color(0xFFFF681B), BlendMode.srcIn)
                  : const ColorFilter.mode(Color(0xFFA7A7A7), BlendMode.srcIn),
            ),
          ],
        ),
      ),
    );
  }
}
