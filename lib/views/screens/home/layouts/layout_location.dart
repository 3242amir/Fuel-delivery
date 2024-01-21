import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fuel_delivery/controllers/location_update_controller.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../utils/circle_painter.dart';

class LocationLayout extends StatelessWidget {
  LocationLayout({super.key});
  Completer<GoogleMapController> completer = Completer();

  @override
  Widget build(BuildContext context) {
    return GetX<LocationUpdateController>(
      init: Get.put(LocationUpdateController()),
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Delivery Detail",
                style: TextStyle(
                    color: Color(0xFF0F0F0F),
                    fontSize: 20.0,
                    fontFamily: 'Oxygen',
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: Get.height * 0.02),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6F6FB),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: GoogleMap(
                            initialCameraPosition: const CameraPosition(
                              target: LatLng(30.964750, 70.939934),
                              zoom: 12.0,
                            ),
                            mapType: MapType.normal,
                            myLocationEnabled: true,
                            compassEnabled: true,
                            markers: controller.markersSubject.value,
                            onMapCreated: (GoogleMapController controller) {
                              completer.complete(controller);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
