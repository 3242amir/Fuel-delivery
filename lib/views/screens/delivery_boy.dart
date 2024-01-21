import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fuel_delivery/models/order_request.dart';
import 'package:flutter_fuel_delivery/models/user.dart' as model;
import 'package:get/get.dart';

import '../../models/order_deliver.dart';

class DeliveryBoy extends StatelessWidget {
  const DeliveryBoy({super.key, required this.orderRequest});
  final OrderRequest orderRequest;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFEFEFE),
        body: Column(
          children: [
            Row(
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
                SizedBox(width: Get.width * 0.01),
                const Text(
                  "Select Delivery Boy",
                  style: TextStyle(
                    color: Color(0xFF0F0F0F),
                    fontSize: 22.0,
                    fontFamily: 'Oxygen',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: Get.height * 0.02),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .where('type', isEqualTo: 'Delivery Boy')
                    .snapshots(),
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    final docs = snapshot.data!.docs;
                    final userList = docs.map((obj) {
                      final user = obj.data();
                      return model.User.fromMap(user);
                    }).toList();
                    if (userList.isNotEmpty) {
                      return ListView.builder(
                        itemCount: userList.length,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        itemBuilder: (context, index) {
                          return Items(
                            onTap: () async {
                              var timeStamp = DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString();
                              var order = OrderDeliver(
                                orderId: orderRequest.timeStamp,
                                uid: userList[index].uid!,
                                timeStamp: timeStamp,
                                isCompleted: false,
                              );
                              await FirebaseFirestore.instance
                                  .collection('order')
                                  .doc(orderRequest.uid)
                                  .update(
                                {'isDeliver': true},
                              );
                              await FirebaseFirestore.instance
                                  .collection('deliver')
                                  .doc(timeStamp)
                                  .set(order.toMap())
                                  .then(
                                    (value) =>
                                        Get.snackbar("Info", 'Order Deliver'),
                                  );
                            },
                            user: userList[index],
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: Text(
                          "No delivery boy",
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
            ),
          ],
        ),
      ),
    );
  }
}

class Items extends StatelessWidget {
  const Items({
    super.key,
    required this.onTap,
    required this.user,
  });
  final VoidCallback onTap;
  final model.User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.9,
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.only(top: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 237, 237, 237),
            blurRadius: 3,
            spreadRadius: 0.3,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (user.imgUrl!.isNotEmpty)
              ? CachedNetworkImage(
                  imageUrl: user.imgUrl!,
                  imageBuilder: (context, imageProvider) => CircleAvatar(
                    radius: 20.0,
                    backgroundImage: imageProvider,
                  ),
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                )
              : const CircleAvatar(
                  radius: 20.0,
                  backgroundImage: AssetImage(
                    'assets/images/default_profile.png',
                  ),
                ),
          SizedBox(width: Get.width * 0.02),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name,
                style: const TextStyle(
                  color: Color(0xFF0F0F0F),
                  fontSize: 18.0,
                  fontFamily: 'Oxygen',
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: Get.height * 0.01),
              const Text(
                "Layyah,Punjab,Pakistan",
                style: TextStyle(
                  color: Color(0xFFA3A3A3),
                  fontSize: 18.0,
                  fontFamily: 'Oxygen',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: Get.height * 0.02),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: onTap,
                  child: const Text(
                    "Deliver",
                    style: TextStyle(
                      color: Color(0xFFFF681B),
                      fontSize: 18.0,
                      fontFamily: 'Oxygen',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
