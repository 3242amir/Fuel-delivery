import 'package:flutter/material.dart';
import 'package:flutter_fuel_delivery/models/fuel_type.dart';
import 'package:get/get.dart';

class FuelTypeItem extends StatelessWidget {
  const FuelTypeItem({
    super.key,
    required this.fuelType,
    required this.isActive,
    required this.onPress,
  });
  final FuelType fuelType;
  final bool isActive;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        margin: const EdgeInsets.only(right: 8.0),
        height: Get.height * 0.17,
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFFF681B) : Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFF6F6FB),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(9.0),
                    topRight: Radius.circular(9.0),
                    bottomLeft: Radius.circular(16.0),
                    bottomRight: Radius.circular(16.0),
                  ),
                ),
                child: Center(
                  child: Image.asset(
                    fuelType.path,
                    width: 55.0,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ),
            ),
            SizedBox(height: Get.height * 0.015),
            Text(
              fuelType.title,
              style: TextStyle(
                fontFamily: 'Oxygen',
                color: isActive ? Colors.white : const Color(0xFF333333),
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: Get.height * 0.015),
          ],
        ),
      ),
    );
  }
}
