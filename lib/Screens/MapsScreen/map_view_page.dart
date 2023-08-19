import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:letsgo/Controllers/maps_controller.dart';

class MapSample extends StatelessWidget {
  MapSample({super.key, required this.latitude, required this.longitude});

  final double latitude;
  final double longitude;
  final Completer<GoogleMapController> _controller = Completer();
  MapController mapController = Get.put(MapController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () => GoogleMap(
        mapType: MapType.hybrid,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        mapToolbarEnabled: true,
        markers: Set<Marker>.of(mapController.markers),
        initialCameraPosition:
            CameraPosition(target: LatLng(latitude, longitude), zoom: 10.0),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    ));
  }
}
