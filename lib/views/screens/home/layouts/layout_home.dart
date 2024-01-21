import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_fuel_delivery/controllers/home_controller.dart';
import 'package:flutter_fuel_delivery/views/widgets/fuel_item.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as location;

import 'package:permission_handler/permission_handler.dart' as permission;

import '../../../../utils/circle_painter.dart';
import '../../quantity_screen.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key, required this.controller});
  final HomeController controller;

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  location.LocationData? _currentLocation;
  location.Location _location = location.Location();
  String? currentAddress;
  String? fuel;
  final Completer<GoogleMapController> _completer =
      Completer<GoogleMapController>();
  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(30.964750, 70.939934),
    zoom: 12.0,
  );

  @override
  void initState() {
    super.initState();
    _location = location.Location();
    _checkLocationPermission();

    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final String? uid = FirebaseAuth.instance.currentUser?.uid;
    final DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    if (snapshot.exists) {
      final Map<String, dynamic>? userData = snapshot.data();
      final String userName = userData?['name'] ?? '';
      final String profileImageURL = userData?['imgUrl'] ?? '';

      setState(() {
        // Update the user name and profile image URL in the state
        widget.controller.userName = userName;
        widget.controller.profileImageURL = profileImageURL;
      });
    }
  }

  Future<void> _checkLocationPermission() async {
    final permission.PermissionStatus permissionStatus =
        await permission.Permission.location.request();
    if (permissionStatus.isGranted) {
      _enableGPS();
    } else if (permissionStatus.isDenied) {
      // Permission denied
      _showPermissionDeniedDialog();
    } else if (permissionStatus.isPermanentlyDenied) {
      // Permission permanently denied
      bool openSettings = await _showOpenSettingsDialog();
      if (openSettings) {
        await permission.openAppSettings();
      }
    }
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Permission Denied'),
          content:
              const Text('Please grant location permission to use the app.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _checkLocationPermission(); // Request permission again
              },
              child: const Text('Retry'),
            ),
          ],
        );
      },
    );
  }

  Future<bool> _showOpenSettingsDialog() async {
    Completer<bool> completer = Completer<bool>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Permission Denied'),
          content: const Text(
              'Please grant location permission from the app settings.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
                completer.complete(false);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
                completer.complete(true);
              },
              child: const Text('Open Settings'),
            ),
          ],
        );
      },
    );

    return completer.future;
  }

  Future<void> _enableGPS() async {
    if (!(await _location.serviceEnabled())) {
      bool serviceStatusResult = await _location.requestService();
      if (!serviceStatusResult) {
        // GPS service not enabled
        _showEnableGPSDialog();
      }
    } else {
      _getCurrentLocation();
    }
  }

  void _showEnableGPSDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enable GPS'),
          content: const Text(
              'GPS is disabled. Enable it to show your current location.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _location.requestService();
              },
              child: const Text('Enable'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _getCurrentLocation() async {
    try {
      _currentLocation = await _location.getLocation();
      if (_currentLocation != null) {
        final GoogleMapController controller = await _completer.future;
        controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(
                _currentLocation!.latitude!,
                _currentLocation!.longitude!,
              ),
              zoom: 12.0,
            ),
          ),
        );

        List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentLocation!.latitude!,
          _currentLocation!.longitude!,
        );

        if (placemarks.isNotEmpty) {
          Placemark placemark = placemarks.first;
          setState(() {
            currentAddress =
                '${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country}';
          });
        }
      }
    } on PlatformException catch (e) {
      // Handle exceptions that may occur while retrieving the location
      print('Error: ${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
                  (widget.controller.profileImageURL.isNotEmpty)
                      ? CachedNetworkImage(
                          imageUrl: widget.controller.profileImageURL,
                          imageBuilder: (context, imageProvider) =>
                              CircleAvatar(
                            radius: 23.0,
                            backgroundImage: imageProvider,
                          ),
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        )
                      : const CircleAvatar(
                          radius: 23.0,
                          backgroundImage: AssetImage(
                            'assets/images/default_profile.png',
                          ),
                        ),
                ],
              ),
              SizedBox(width: Get.width * 0.02),
              Text(
                widget.controller.userName,
                style: const TextStyle(
                  fontSize: 19.0,
                  fontFamily: 'Oxygen',
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF080808),
                ),
              ),
            ],
          ),
          SizedBox(height: Get.height * 0.03),
          const Text(
            'Where is your car parked?',
            style: TextStyle(
              fontSize: 19.0,
              fontFamily: 'Oxygen',
              fontWeight: FontWeight.w500,
              color: Color(0xFF676767),
            ),
          ),
          SizedBox(height: Get.height * 0.01),
          Container(
            alignment: Alignment.centerLeft,
            width: double.infinity,
            padding: const EdgeInsets.only(left: 8.0),
            height: 50.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                width: 1.0,
                color: const Color.fromARGB(255, 171, 171, 171),
              ),
            ),
            child: Text(
              currentAddress ?? '',
              style: const TextStyle(
                fontSize: 18.0,
                fontFamily: 'Oxygen',
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: Get.height * 0.02),
          SizedBox(
            width: Get.width,
            height: Get.height * 0.33,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: GoogleMap(
                initialCameraPosition: _initialPosition,
                mapType: MapType.normal,
                myLocationEnabled: true,
                compassEnabled: true,
                onMapCreated: (GoogleMapController controller) {
                  _completer.complete(controller);
                },
              ),
            ),
          ),
          SizedBox(height: Get.height * 0.02),
          Text(
            widget.controller.txt.value,
            style: const TextStyle(
              fontSize: 19.0,
              fontFamily: 'Oxygen',
              fontWeight: FontWeight.w500,
              color: Color(0xFF676767),
            ),
          ),
          SizedBox(height: Get.height * 0.02),
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                widget.controller.itemType.length,
                (index) => Expanded(
                  child: FuelTypeItem(
                    fuelType: widget.controller.itemType[index],
                    onPress: () {
                      fuel = widget.controller.itemType[index].title;
                      Get.to(QuantityScreen(
                        fuelType: fuel!,
                        latitude: _currentLocation!.latitude,
                        longitude: _currentLocation!.longitude,
                      ));
                      widget.controller.setPosition = index;
                    },
                    isActive: widget.controller.position == index,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
