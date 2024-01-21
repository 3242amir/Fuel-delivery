// ignore_for_file: prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_fuel_delivery/models/order_request.dart';
import 'package:get/get.dart';

class QualtiyController extends GetxController {
  RxInt _index = 0.obs;

  set setIndex(int index) => _index.value = index;
  int get index => _index.value;

  RxInt? quantity = 0.obs;
  RxString fuelType = ''.obs;

  num get simplePrice {
    if (fuelType.value == 'Petrol' || fuelType.value == 'Diesel') {
      return (quantity?.value ?? 0) * 253;
    } else {
      return (quantity?.value ?? 0) * 210;
    }
  }

  List<String> get items => [
        'Premium Unleaded ${fuelType.value}\nRS ${fuelType.value == 'Petrol' || fuelType.value == 'Diesel' ? '253.5' : '210'} / ${fuelType.value == 'Petrol' || fuelType.value == 'Diesel' ? 'Letter' : 'KG'}',
        'Super Unleaded ${fuelType.value}\nRS ${fuelType.value == 'Petrol' || fuelType.value == 'Diesel' ? '260' : '215'}/ ${fuelType.value == 'Petrol' || fuelType.value == 'Diesel' ? 'Letter' : 'KG'}',
        'Xtra Premium ${fuelType.value}\nRS ${fuelType.value == 'Petrol' || fuelType.value == 'Diesel' ? '265' : '230'}/ ${fuelType.value == 'Petrol' || fuelType.value == 'Diesel' ? 'Letter' : 'KG'}',
        'V Power ${fuelType.value}\nRS ${fuelType.value == 'Petrol' || fuelType.value == 'Diesel' ? '280' : '235'}/ ${fuelType.value == 'Petrol' || fuelType.value == 'Diesel' ? 'Letter' : 'KG'}',
      ];

  String get finalType {
    return items[index].split('\n').first;
  }

  num finalPrice() {
    String selectedFuelType = items[index].split('\n').first;
    if (selectedFuelType == 'Premium Unleaded $fuelType') {
      return (quantity?.value ?? 0) *
          (fuelType.value == 'Petrol' || fuelType.value == 'Diesel'
              ? 253.5
              : 210);
    } else if (selectedFuelType == 'Super Unleaded $fuelType') {
      return (quantity?.value ?? 0) *
          (fuelType.value == 'Petrol' || fuelType.value == 'Diesel'
              ? 260
              : 215);
    } else if (selectedFuelType == 'Xtra Premium $fuelType') {
      return (quantity?.value ?? 0) *
          (fuelType.value == 'Petrol' || fuelType.value == 'Diesel'
              ? 265
              : 230);
    } else if (selectedFuelType == 'V Power $fuelType') {
      return (quantity?.value ?? 0) *
          (fuelType.value == 'Petrol' || fuelType.value == 'Diesel'
              ? 280
              : 235);
    } else {
      return 0;
    }
  }

  num get orderTotal {
    return finalPrice() + 200 + 50;
  }

  double? latitude;
  double? longitude;

  Future<String> orderRequest() async {
    String response = "";
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      String timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
      var request = OrderRequest(
        uid: uid,
        fuelType: finalType,
        totalPrice: orderTotal.toDouble(),
        timeStamp: timeStamp,
        deliveryCharges: '200',
        taxes: '50',
        latitude: latitude!,
        longitude: longitude!,
        isDeliver: false,
        quantity:
            '${quantity!.value} ${fuelType.contains("Petrol") || fuelType.contains("Diesel") ? 'Letter' : 'KG'}',
      );
      await FirebaseFirestore.instance
          .collection('order')
          .doc(uid)
          .set(request.toMap())
          .then((value) => response = "Order sent Successfully")
          .onError((error, stackTrace) => response = error.toString());
    } catch (e) {
      print('Error uploading order data: $e');
    }
    return response;
  }
}
