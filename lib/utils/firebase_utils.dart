import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fuel_delivery/models/user.dart' as model;
import 'package:flutter_fuel_delivery/views/screens/admin/admin.dart';
import 'package:flutter_fuel_delivery/views/screens/delivery_home.dart';
import 'package:flutter_fuel_delivery/views/screens/home/home.dart';
import 'package:flutter_fuel_delivery/views/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Widget> getScreen() async {
  Widget screen = const LoginScreen();
  if (await isAdmin()) {
    screen = const AdminScreen();
  } else {
    if (FirebaseAuth.instance.currentUser != null) {
      var uid = FirebaseAuth.instance.currentUser!.uid;
      var user = await getUserById(uid);
      if (user.type == 'Delivery Boy') {
        screen = const DeliveryHome();
      } else {
        screen = const Home();
      }
    }
  }

  return screen;
}

Map<String, model.User> getUser = {};

Future<bool> isAdmin() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool("isAdmin") ?? false;
}

Future<model.User> getUserById(String uid) async {
  if (getUser.containsKey(uid)) {
    return getUser[uid]!;
  }
  var userDoc =
      await FirebaseFirestore.instance.collection("users").doc(uid).get();
  model.User user = model.User.fromMap(userDoc.data() as Map<String, dynamic>);

  return user;
}
