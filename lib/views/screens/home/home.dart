import 'package:flutter/material.dart';
import 'package:flutter_fuel_delivery/controllers/home_controller.dart';
import 'package:flutter_fuel_delivery/views/widgets/bottom_item.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Obx(
              () => Expanded(
                flex: 8,
                child: controller.layouts[controller.index],
              ),
            ),
            Expanded(
              flex: 1,
              child: BottomItem(
                controller: controller,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
