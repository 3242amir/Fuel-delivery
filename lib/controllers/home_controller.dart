import 'package:flutter/material.dart';
import 'package:flutter_fuel_delivery/views/screens/home/layouts/layout_home.dart';
import 'package:flutter_fuel_delivery/views/screens/home/layouts/layout_location.dart';
import 'package:flutter_fuel_delivery/views/screens/home/layouts/layout_profile.dart';
import 'package:get/get.dart';

import '../models/fuel_type.dart';

class HomeController extends GetxController {
  // ignore: prefer_final_fields
  RxInt _index = 0.obs;

  set setIndex(int index) => _index.value = index;
  int get index => _index.value;

  List<String> get items => [
        'assets/icons/home.svg',
        'assets/icons/location.svg',
        'assets/icons/settings.svg',
      ];

  List<Widget> get layouts => [
        HomeLayout(controller: this),
        LocationLayout(),
        const ProfileLayout(),
      ];

  // ignore: prefer_final_fields
  RxInt _position = 0.obs;
  set setPosition(int index) => _position.value = index;
  int get position => _position.value;
  List<FuelType> get itemType => [
        FuelType(path: 'assets/images/pump.png', title: 'Petrol'),
        FuelType(path: 'assets/images/caen.png', title: 'Diesel'),
        FuelType(path: 'assets/images/gas.png', title: 'Gas'),
      ];
  RxString txt = 'Choose your fuel type.'.obs;

  String userName = '';
  String profileImageURL = '';
}
