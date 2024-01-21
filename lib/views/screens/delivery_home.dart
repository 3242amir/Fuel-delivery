import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fuel_delivery/models/order_deliver.dart';
import 'package:flutter_fuel_delivery/models/order_request.dart';
import 'package:flutter_fuel_delivery/views/screens/google_map.dart';
import 'package:get/get.dart';

import '../../utils/circle_painter.dart';

class DeliveryHome extends StatelessWidget {
  const DeliveryHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFEFEFE),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection("users")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Row(
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            clipBehavior: Clip.none,
                            children: const [
                              CustomPaint(
                                size: Size(53, 53),
                                painter: CirclePainter(
                                  Color.fromARGB(255, 215, 215, 215),
                                  1.5,
                                ),
                              ),
                              CircleAvatar(
                                radius: 23.0,
                                backgroundImage: AssetImage(
                                    'assets/images/default_profile.png'),
                                backgroundColor: Color(0xFFA7A7A7),
                              ),
                            ],
                          ),
                          SizedBox(width: Get.width * 0.02),
                          const Text(
                            '....',
                            style: TextStyle(
                              fontSize: 19.0,
                              fontFamily: 'Oxygen',
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF080808),
                            ),
                          ),
                        ],
                      );
                    } else {
                      if (snapshot.hasData) {
                        var userData = snapshot.data!.data();
                        String userName = userData?['name'] ?? '';
                        String profileImageUrl = userData?['pimgUrl'] ?? '';
                        return Row(
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              clipBehavior: Clip.none,
                              children: [
                                const CustomPaint(
                                  size: Size(53, 53),
                                  painter: CirclePainter(
                                    Color.fromARGB(255, 215, 215, 215),
                                    1.5,
                                  ),
                                ),
                                (profileImageUrl.isNotEmpty)
                                    ? CachedNetworkImage(
                                        imageUrl: profileImageUrl,
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          width: 23.0,
                                          height: 23.0,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        placeholder: (context, url) =>
                                            Container(
                                          width: 23.0,
                                          height: 23.0,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xFFA7A7A7),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Container(
                                          width: 23.0,
                                          height: 23.0,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xFFA7A7A7),
                                          ),
                                        ),
                                      )
                                    : const CircleAvatar(
                                        radius: 23.0,
                                        backgroundImage: AssetImage(
                                            'assets/images/default_profile.png'),
                                        backgroundColor: Color(0xFFA7A7A7),
                                      ),
                              ],
                            ),
                            SizedBox(width: Get.width * 0.02),
                            Text(
                              userName,
                              style: const TextStyle(
                                fontSize: 19.0,
                                fontFamily: 'Oxygen',
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF080808),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const Text('Error fetching user data');
                      }
                    }
                  }),
            ),
            SizedBox(height: Get.height * 0.02),
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                'Achive New Order',
                style: TextStyle(
                  fontSize: 19.0,
                  fontFamily: 'Oxygen',
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF080808),
                ),
              ),
            ),
            SizedBox(height: Get.height * 0.02),
            Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('deliver')
                      .where("uid",
                          isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                      .where("isCompleted", isEqualTo: false)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final docs = snapshot.data!.docs;
                      final newOrderList = docs.map((e) {
                        final order = e.data();
                        return OrderDeliver.fromMap(order);
                      }).toList();
                      if (newOrderList.isNotEmpty) {
                        return ListView.builder(
                            itemCount: newOrderList.length,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            itemBuilder: (context, index) {
                              return FutureBuilder<OrderRequest?>(
                                future: fetchOrder(newOrderList[index].orderId),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 3.8,
                                        backgroundColor:
                                            Color.fromARGB(255, 165, 180, 209),
                                      ),
                                    );
                                  } else {
                                    if (snapshot.hasError) {
                                      return const Text('Error loading order');
                                    } else {
                                      return Items(
                                        orderRequest: snapshot.data!,
                                        onPress: () {
                                          Get.to(GooglMapScreen(
                                            timeStamp:
                                                newOrderList[index].timeStamp,
                                            latitude: snapshot.data!.latitude,
                                            longitude: snapshot.data!.longitude,
                                            uid: snapshot.data!.uid,
                                          ));
                                        },
                                      );
                                    }
                                  }
                                },
                              );
                            });
                      } else {
                        return const Center(
                          child: Text(
                            "No Order yet ",
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
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Future<OrderRequest?> fetchOrder(String orderId) async {
    var orderSnapshot = await FirebaseFirestore.instance
        .collection('order')
        .where("timeStamp", isEqualTo: orderId)
        .get();

    if (orderSnapshot.docs.isNotEmpty) {
      var orderData = orderSnapshot.docs[0].data();
      return OrderRequest.fromMap(orderData);
    } else {
      return null;
    }
  }
}

class Items extends StatelessWidget {
  const Items({super.key, required this.onPress, required this.orderRequest});
  final VoidCallback onPress;
  final OrderRequest orderRequest;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
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
                            orderRequest.quantity!,
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
                  SizedBox(height: Get.height * 0.01),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
