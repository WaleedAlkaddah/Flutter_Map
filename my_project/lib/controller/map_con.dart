import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart' as lottie;
import 'package:flutter_map_animations/flutter_map_animations.dart';
import '../waleed_widget/animated_marker.dart';

class Map_Controller extends GetxController {
  List<AnimatedMarker> markers = [];
  LatLng? firstMarker;
  LatLng? secondMarker;
  LatLng? setMarker;
  String defultmap = "https://a.tile.openstreetmap.org/{z}/{x}/{y}.png";
  String satelliteMap = "https://mt1.google.com/vt/lyrs=s&x={x}&y={y}&z={z}";
  String terrainMap = 'https://a.tile.opentopomap.org/{z}/{x}/{y}.png';
  final TextEditingController latController1 = TextEditingController();
  final TextEditingController longController1 = TextEditingController();
  final TextEditingController latController2 = TextEditingController();
  final TextEditingController longController2 = TextEditingController();
  AnimatedMark animatedMarker = AnimatedMark();

  void handleTap(tapPosition, LatLng latLng1) {
    if (markers.length < 2) {
      markers.add(
        animatedMarker.buildAnimatedMarker(latLng1, 'lib/asseets/60.json'),
      );

      if (firstMarker == null) {
        firstMarker = latLng1;
        print("firstMarker $firstMarker");
      } else {
        secondMarker = latLng1;
        print("secondMarker $secondMarker");
      }
    }
    print("Markers Count In Map Controller : ${markers.length}");
    update();
  }

  setCoordinate() {
    if (latController2.text.isNotEmpty && latController2.text.isNotEmpty) {
      secondMarker = LatLng(
        double.parse(latController2.text),
        double.parse(longController2.text),
      );
      markers.add(
        animatedMarker.buildAnimatedMarker(
            secondMarker!, 'lib/asseets/60.json'),
      );
    } else if (latController1.text.isNotEmpty &&
        latController1.text.isNotEmpty) {
      firstMarker = LatLng(
        double.parse(latController1.text),
        double.parse(longController1.text),
      );
      markers.add(
        animatedMarker.buildAnimatedMarker(firstMarker!, 'lib/asseets/60.json'),
      );
    } else {
      print("Invalid input for latitude or longitude");
    }

    print("firstMarker : $firstMarker , secondMarker :  $secondMarker");
    update();
  }

  void clearMarkers() {
    markers.clear();
    firstMarker = null;
    secondMarker = null;
    print("Cleared");
    update();
  }

   updateMap(String mapStyle) {
    defultmap = mapStyle;
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
