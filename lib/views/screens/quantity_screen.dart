import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'delivery/book_for_delivery.dart';

class QuantityScreen extends StatelessWidget {
  QuantityScreen({
    super.key,
    required this.fuelType,
    this.latitude,
    this.longitude,
  });
  final String fuelType;
  double? latitude, longitude;
  var quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFEFEFE),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Get.height * 0.015),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  splashRadius: 22.0,
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                  ),
                ),
                SizedBox(width: Get.width * 0.01),
                const Text(
                  "Add Quantity",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28.0,
                    fontFamily: 'Oxygen',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: Get.height * 0.02),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Get.height * 0.02),
                  TextFormField(
                    controller: quantityController,
                    decoration: InputDecoration(
                      hintText: "Quantity",
                      hintStyle: const TextStyle(
                        fontSize: 17.0,
                        fontFamily: 'Oxygen',
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFFF6F6FB),
                          width: 0.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFFF6F6FB),
                          width: 0.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      fillColor: const Color(0xFFF6F6FB),
                      filled: true,
                    ),
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  SizedBox(height: Get.height * 0.02),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(BookForDelivery(
                        quantity: int.parse(quantityController.text),
                        fueltType: fuelType,
                        latitude: latitude ?? 0,
                        longitude: longitude ?? 0,
                      ));
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color(0xFFFF681B),
                      minimumSize: Size(Get.width * 0.9, 52.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text(
                      'Next',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 17.0, fontFamily: 'Oxygen'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
