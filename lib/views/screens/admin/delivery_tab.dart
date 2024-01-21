import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fuel_delivery/models/order_request.dart';
import 'package:get/get.dart';

class DeliveryTab extends StatelessWidget {
  const DeliveryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("order")
          .where("isDeliver", isEqualTo: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final docs = snapshot.data!.docs;
          final orderList = docs.map((e) {
            final order = e.data();
            return OrderRequest.fromMap(order);
          }).toList();
          if (orderList.isNotEmpty) {
            return ListView.builder(
              itemCount: orderList.length,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemBuilder: (context, index) {
                return Items(
                  orderDeliver: orderList[index],
                );
              },
            );
          } else {
            return const Center(
              child: Text(
                "No Order delivery ",
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
      },
    );
  }
}

class Items extends StatelessWidget {
  const Items({super.key, required this.orderDeliver});
  final OrderRequest orderDeliver;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
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
                Text(
                  orderDeliver.fuelType,
                  style: const TextStyle(
                    color: Color(0xFF0F0F0F),
                    fontSize: 18.0,
                    fontFamily: 'Oxygen',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: Get.height * 0.01),
                Text(
                  orderDeliver.quantity!,
                  style: const TextStyle(
                    color: Color(0xFFA3A3A3),
                    fontSize: 18.0,
                    fontFamily: 'Oxygen',
                    fontWeight: FontWeight.w600,
                  ),
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
                      "RS ${orderDeliver.deliveryCharges}",
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
                      "RS ${orderDeliver.taxes}",
                      style: const TextStyle(
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
            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
            color: const Color(0xFFF6F6FB),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: Get.height * 0.01),
                        const Text(
                          "Order Total",
                          style: TextStyle(
                            color: Color(0xFF0F0F0F),
                            fontSize: 18.0,
                            fontFamily: 'Oxygen',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Text(
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
                      "RS ${orderDeliver.totalPrice}",
                      style: const TextStyle(
                        color: Color(0xFF0F0F0F),
                        fontSize: 20.0,
                        fontFamily: 'Oxygen',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Get.height * 0.01),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
