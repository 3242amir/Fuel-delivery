import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fuel_delivery/models/user_location.dart';
import 'package:flutter_fuel_delivery/views/screens/delivery_home.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GooglMapScreen extends StatefulWidget {
  const GooglMapScreen(
      {super.key,
      required this.latitude,
      required this.longitude,
      required this.timeStamp,
      required this.uid});
  final double latitude, longitude;
  final String timeStamp;
  final String uid;

  @override
  State<GooglMapScreen> createState() => _GooglMapScreenState();
}

class _GooglMapScreenState extends State<GooglMapScreen> {
  Completer<GoogleMapController> completer = Completer();

  Set<Marker> createMarkers() {
    return <Marker>{
      Marker(
        markerId: const MarkerId('customMarker'),
        position: LatLng(widget.latitude, widget.longitude),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow: const InfoWindow(title: 'Order Location'),
      ),
    };
  }

  late Timer _timer;
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    // Start fetching location data every 2 or 5 seconds
    const updateInterval = Duration(seconds: 3); // Change interval here
    _timer = Timer.periodic(updateInterval, (timer) {
      _getCurrentLocation();
    });
  }

  @override
  void dispose() {
    // Stop the timer when the widget is disposed
    _timer.cancel();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        print('Location services are disabled');
        return;
      }

      // Check for permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.deniedForever) {
        print('Location permissions are permanently denied');
        _showLocationPermissionDialog();
        return;
      }

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.whileInUse &&
            permission != LocationPermission.always) {
          print('Location permissions are denied');
          return;
        }
      }

      // Get the current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
      setState(() {
        _currentPosition = position;
      });

      if (_currentPosition != null) {
        String currentId = FirebaseAuth.instance.currentUser!.uid;
        var userLocation = UserLocation(
          uid: widget.uid,
          deliveryId: currentId,
          latitude: _currentPosition!.latitude,
          longitude: _currentPosition!.longitude,
        );
        await FirebaseFirestore.instance
            .collection('location')
            .doc(widget.uid)
            .set(userLocation.toMap(), SetOptions(merge: true));
      }
    } catch (e) {
      print('Error fetching location: $e');
    }
  }

  void _showLocationPermissionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Location Permissions Required'),
          content: const Text(
              'Please grant location permissions in order to use this app.'),
          actions: [
            TextButton(
              onPressed: () {
                // Open the app settings to allow the user to grant permissions.
                Geolocator.openAppSettings();
                Navigator.pop(context);
              },
              child: const Text('Open Settings'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(widget.latitude, widget.longitude),
                zoom: 19.0,
              ),
              mapType: MapType.normal,
              myLocationEnabled: true,
              compassEnabled: true,
              markers: createMarkers(),
              onMapCreated: (GoogleMapController controller) {
                completer.complete(controller);
              },
            ),
            Positioned(
              left: Get.width * 0.2,
              right: Get.width * 0.2,
              bottom: Get.width * 0.15,
              child: ElevatedButton(
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection("deliver")
                      .doc(widget.timeStamp)
                      .update({"isCompleted": true});
                  Get.off(const DeliveryHome());
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF681B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    minimumSize: Size(Get.width * 0.02, 55.0)),
                child: const Text(
                  'Done',
                  style: TextStyle(
                    fontSize: 17.0,
                    fontFamily: 'Oxygen',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
