import 'package:flutter/material.dart';
import 'package:flutter_fuel_delivery/controllers/quality_controller.dart';
import 'package:flutter_fuel_delivery/views/screens/booking/conform_booking.dart';
import 'package:flutter_fuel_delivery/views/screens/delivery/select_quantity.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class BookForDelivery extends StatelessWidget {
  BookForDelivery({
    Key? key,
    required this.quantity,
    required this.fueltType,
    this.latitude,
    this.longitude,
  }) : super(key: key);
  final int quantity;
  final String fueltType;
  double? latitude, longitude;

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(QualtiyController());
    controller.fuelType.value = fueltType;
    controller.quantity!.value = quantity;
    controller.latitude = latitude;
    controller.longitude = longitude;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFEFEFE),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                Get.back();
              },
              splashRadius: 20.0,
              icon: const Icon(
                Icons.arrow_back,
                size: 28.0,
                color: Color(0xFF0F0F0F),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        fueltType,
                        style: const TextStyle(
                          color: Color(0xFF0F0F0F),
                          fontSize: 22.0,
                          fontFamily: 'Oxygen',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.02),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/fuel.svg',
                                  width: 35,
                                  colorFilter: const ColorFilter.mode(
                                    Color(0xFFFF681B),
                                    BlendMode.srcIn,
                                  ),
                                ),
                                SizedBox(height: Get.height * 0.005),
                                Text(
                                  '$quantity',
                                  style: const TextStyle(
                                    color: Color(0xFF0F0F0F),
                                    fontSize: 30.0,
                                    fontFamily: 'Oxygen',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: Get.height * 0.01),
                                Text(
                                  "Quantity in ${controller.fuelType.value == ('Petrol') || controller.fuelType.value == ('Diesel') ? 'Letter' : 'KG'}",
                                  style: const TextStyle(
                                    color: Color(0xFFB8B6B6),
                                    fontSize: 18.0,
                                    fontFamily: 'Oxygen',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: Get.height * 0.03),
                                SvgPicture.asset(
                                  'assets/icons/cash.svg',
                                  width: 35,
                                  colorFilter: const ColorFilter.mode(
                                    Color(0xFFFF681B),
                                    BlendMode.srcIn,
                                  ),
                                ),
                                SizedBox(height: Get.height * 0.005),
                                Text(
                                  "RS ${controller.simplePrice}",
                                  style: const TextStyle(
                                    color: Color(0xFF0F0F0F),
                                    fontSize: 30.0,
                                    fontFamily: 'Oxygen',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: Get.height * 0.007),
                                const Text(
                                  "Cast",
                                  style: TextStyle(
                                    color: Color(0xFFB8B6B6),
                                    fontSize: 18.0,
                                    fontFamily: 'Oxygen',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Image.asset(
                            'assets/images/side_img.png',
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Select Quality",
                            style: TextStyle(
                              color: Color(0xFF0F0F0F),
                              fontSize: 25.0,
                              fontFamily: 'Oxygen',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: Get.height * 0.01),
                          SelectQuantity(
                            controller: controller,
                          ),
                          SizedBox(height: Get.height * 0.02),
                          ElevatedButton(
                            onPressed: () {
                              Get.to(const ConformBooking());
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFF681B),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                minimumSize: Size(Get.width, 55.0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  'Book For Delivery',
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    fontFamily: 'Oxygen',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Icon(Icons.arrow_forward),
                              ],
                            ),
                          ),
                          SizedBox(height: Get.height * 0.01),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
