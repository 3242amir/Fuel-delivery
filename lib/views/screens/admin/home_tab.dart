import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fuel_delivery/views/screens/delivery_boy.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';

import '../../../models/order_request.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('order')
            .where('isDeliver', isEqualTo: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final orders = snapshot.data!.docs;
            final orderRequests = orders.map((order) {
              final data = order.data();
              return OrderRequest.fromMap(data);
            }).toList();
            if (orderRequests.isNotEmpty) {
              return ListView.builder(
                itemCount: orderRequests.length,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemBuilder: (context, index) {
                  return Item(
                    orderRequest: orderRequests[index],
                    onPress: () {
                      Get.to(DeliveryBoy(
                        orderRequest: orderRequests[index],
                      ));
                    },
                  );
                },
              );
            } else {
              return const Center(
                child: Text(
                  "No Order yet",
                  style: TextStyle(
                    color: Color(0xFFA3A3A3),
                    fontSize: 18.0,
                    fontFamily: 'Oxygen',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 3.8,
                backgroundColor: Color.fromARGB(255, 165, 180, 209),
              ),
            );
          }
        });
  }
}

class Item extends StatelessWidget {
  const Item({
    super.key,
    required this.onPress,
    required this.orderRequest,
  });
  final VoidCallback onPress;
  final OrderRequest orderRequest;

  Future<String> getAddressFromLatLng(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        String city = placemark.locality ?? '';
        String province = placemark.administrativeArea ?? '';
        String country = placemark.country ?? '';
        return "$city, $province, $country";
      }
    } catch (e) {
      print("Error fetching location: $e");
    }
    return "Unknown Location";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12.0),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          orderRequest.fuelType,
                          style: const TextStyle(
                            color: Color(0xFF0F0F0F),
                            fontSize: 18.0,
                            fontFamily: 'Oxygen',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: Get.height * 0.01),
                        Text(
                          orderRequest.quantity.toString(),
                          style: const TextStyle(
                            color: Color(0xFFA3A3A3),
                            fontSize: 18.0,
                            fontFamily: 'Oxygen',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: Get.height * 0.02),
                const Divider(),
                SizedBox(height: Get.height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Delivery Charges",
                      style: TextStyle(
                        color: Color(0xFFA3A3A3),
                        fontSize: 18.0,
                        fontFamily: 'Oxygen',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "RS ${orderRequest.deliveryCharges}",
                      style: const TextStyle(
                        color: Color(0xFF0F0F0F),
                        fontSize: 20.0,
                        fontFamily: 'Oxygen',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Get.height * 0.015),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Taxes",
                      style: TextStyle(
                        color: Color(0xFFA3A3A3),
                        fontSize: 18.0,
                        fontFamily: 'Oxygen',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "RS ${orderRequest.taxes}",
                      style: const TextStyle(
                        color: Color(0xFF0F0F0F),
                        fontSize: 20.0,
                        fontFamily: 'Oxygen',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Get.height * 0.015),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Location",
                      style: TextStyle(
                        color: Color(0xFFA3A3A3),
                        fontSize: 18.0,
                        fontFamily: 'Oxygen',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    FutureBuilder<String>(
                      future: getAddressFromLatLng(
                        orderRequest.latitude,
                        orderRequest.longitude,
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: Text(
                              "...",
                              style: TextStyle(
                                color: Color(0xFF0F0F0F),
                                fontSize: 16.0,
                                fontFamily: 'Oxygen',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        } else if (snapshot.hasData) {
                          return Text(
                            snapshot.data!,
                            style: const TextStyle(
                              color: Color(0xFF0F0F0F),
                              fontSize: 16.0,
                              fontFamily: 'Oxygen',
                              fontWeight: FontWeight.w600,
                            ),
                          );
                        } else {
                          return const Text(
                            "Unknown Location",
                            style: TextStyle(
                              color: Color(0xFF0F0F0F),
                              fontSize: 16.0,
                              fontFamily: 'Oxygen',
                              fontWeight: FontWeight.w600,
                            ),
                          );
                        }
                      },
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
            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
            color: const Color(0xFFF6F6FB),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
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
                  "RS ${orderRequest.totalPrice}",
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
          SizedBox(height: Get.height * 0.02),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: onPress,
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  "Deliver",
                  style: TextStyle(
                    color: Color(0xFFFF681B),
                    fontSize: 19.0,
                    fontFamily: 'Oxygen',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
