import 'package:flutter/material.dart';
import 'package:flutter_fuel_delivery/views/screens/home/home.dart';
import 'package:get/get.dart';

import '../../../controllers/quality_controller.dart';

class ConformBooking extends StatelessWidget {
  const ConformBooking({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetX<QualtiyController>(
        init: Get.put(QualtiyController()),
        builder: (controller) {
          return Scaffold(
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
                SizedBox(height: Get.height * 0.01),
                const Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Text(
                    "Conform Booking",
                    style: TextStyle(
                      color: Color(0xFF0F0F0F),
                      fontSize: 22.0,
                      fontFamily: 'Oxygen',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: Get.height * 0.03),
                          const Text(
                            "Payment Summery",
                            style: TextStyle(
                              color: Color(0xFF0F0F0F),
                              fontSize: 18.0,
                              fontFamily: 'Oxygen',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: Get.height * 0.03),
                          Container(
                            width: Get.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromARGB(255, 237, 237, 237),
                                  blurRadius: 3,
                                  spreadRadius: 0.3,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                controller.finalType,
                                                style: const TextStyle(
                                                  color: Color(0xFF0F0F0F),
                                                  fontSize: 18.0,
                                                  fontFamily: 'Oxygen',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              SizedBox(
                                                  height: Get.height * 0.01),
                                              Text(
                                                '${controller.quantity} ${controller.fuelType.value == 'Petrol' || controller.fuelType.value == 'Diesel' ? 'Letter' : 'KG'}',
                                                style: const TextStyle(
                                                  color: Color(0xFFA3A3A3),
                                                  fontSize: 18.0,
                                                  fontFamily: 'Oxygen',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "${controller.finalPrice()}",
                                            style: const TextStyle(
                                              color: Color(0xFF0F0F0F),
                                              fontSize: 20.0,
                                              fontFamily: 'Oxygen',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: Get.height * 0.02),
                                      const Divider(),
                                      SizedBox(height: Get.height * 0.02),
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Delivery Charges",
                                            style: TextStyle(
                                              color: Color(0xFFA3A3A3),
                                              fontSize: 18.0,
                                              fontFamily: 'Oxygen',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            "RS 200",
                                            style: TextStyle(
                                              color: Color(0xFF0F0F0F),
                                              fontSize: 20.0,
                                              fontFamily: 'Oxygen',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: Get.height * 0.015),
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Taxes",
                                            style: TextStyle(
                                              color: Color(0xFFA3A3A3),
                                              fontSize: 18.0,
                                              fontFamily: 'Oxygen',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            "RS 50",
                                            style: TextStyle(
                                              color: Color(0xFF0F0F0F),
                                              fontSize: 20.0,
                                              fontFamily: 'Oxygen',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: Get.height * 0.02),
                                Container(
                                  width: Get.width,
                                  alignment: Alignment.center,
                                  height: Get.height * 0.08,
                                  padding: const EdgeInsets.only(
                                      left: 12.0, right: 12.0),
                                  color: const Color(0xFFF6F6FB),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Order Total",
                                            style: TextStyle(
                                              color: Color(0xFF0F0F0F),
                                              fontSize: 18.0,
                                              fontFamily: 'Oxygen',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            "Include all taxes",
                                            style: TextStyle(
                                              color: Color(0xFFA3A3A3),
                                              fontSize: 18.0,
                                              fontFamily: 'Oxygen',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "${controller.orderTotal}",
                                        style: const TextStyle(
                                          color: Color(0xFF0F0F0F),
                                          fontSize: 20.0,
                                          fontFamily: 'Oxygen',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: Get.height * 0.03),
                          ElevatedButton(
                            onPressed: () async {
                              String response = await controller.orderRequest();
                              Get.snackbar("Request", response);
                              Get.offAll(const Home());
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFF681B),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                minimumSize: Size(Get.width, 55.0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Cash On Delivery RS ${controller.orderTotal}',
                                  style: const TextStyle(
                                    fontSize: 17.0,
                                    fontFamily: 'Oxygen',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Icon(Icons.arrow_forward),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
