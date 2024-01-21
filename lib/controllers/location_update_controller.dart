import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_fuel_delivery/models/user_location.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationUpdateController extends GetxController {
  var userLocation = Rx<UserLocation?>(null);
  Rx<Set<Marker>> markersSubject = Rx<Set<Marker>>(<Marker>{}.obs);

  @override
  void onInit() {
    super.onInit();
    userLocation.bindStream(
      FirebaseFirestore.instance
          .collection("location")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .snapshots()
          .map(
            (event) =>
                UserLocation.fromMap(event.data() as Map<String, dynamic>),
          ),
    );
    ever(userLocation, _updateMarkers);
  }

  void _updateMarkers(UserLocation? location) {
    if (location != null) {
      final updatedMarker = Marker(
        markerId: MarkerId(location.deliveryId),
        position: LatLng(location.latitude, location.longitude),
        infoWindow: const InfoWindow(title: 'Delivery Boy'),
        // icon: BitmapDescriptor.fromAsset('assets/icon.png'),
      );

      markersSubject.value
          .removeWhere((marker) => marker.markerId == updatedMarker.markerId);
      markersSubject.value.add(updatedMarker);

      markersSubject.refresh();
    }
  }
}
