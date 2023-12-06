import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:get/get.dart';

class MapController extends GetxController {
  List<Marker> markers = [];
  LatLng? firstMarker;
  LatLng? secondMarker;

  void handleTap(tapPosition, LatLng latLng1) {
    if (markers.length < 2) {
      markers.add(
        Marker(
          width: 20,
          height: 20,
          point: latLng1,
          builder: (ctx) => const Icon(
            Icons.gps_not_fixed_sharp,
            color: Colors.green,
            size: 30.0,
          ),
        ),
      );

      if (firstMarker == null) {
        firstMarker = latLng1;
        print("firstMarker $firstMarker");
      } else {
        secondMarker = latLng1;
        print("secondMarker $secondMarker");
      }
    }
    update();
  }

  void clearMarkers() {
    markers.clear();
    print("Cleared");
    update();
  }

  void calculateDistance() {
    if (firstMarker != null && secondMarker != null) {
      double distance = Distance().as(
        LengthUnit.Kilometer,
        firstMarker!,
        secondMarker!,
      );
      print("firstMarker calculateDistance $firstMarker");
      print("secondMarker calculateDistance $secondMarker");
      Get.defaultDialog(
        title: 'Distance',
        middleText: 'Distance between markers: $distance Kilometer',
        textConfirm: 'OK',
        onConfirm: () {
          Get.back();
        },
      );
    }
  }
}
