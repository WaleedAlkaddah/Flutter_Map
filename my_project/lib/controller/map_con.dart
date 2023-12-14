import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart' as flutter_map;
import 'package:lottie/lottie.dart' as lottie;
import 'package:my_project/controller/search_con.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';

class Map_Controller extends GetxController{
  List<AnimatedMarker> markers = [];
  LatLng? firstMarker;
  LatLng? secondMarker;
  String defultmap = "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png";
  String satellite_map = "https://mt1.google.com/vt/lyrs=s&x={x}&y={y}&z={z}";
  String terrain_map = 'https://{s}.tile.opentopomap.org/{z}/{x}/{y}.png';
  final TextEditingController latController1 = TextEditingController();
  final TextEditingController longController1 = TextEditingController();
  final TextEditingController latController2 = TextEditingController();
  final TextEditingController longController2 = TextEditingController();


  void handleTap(tapPosition, LatLng latLng1) {
    if (markers.length < 2) {
      markers.add(
        AnimatedMarker(
          point: latLng1,
          builder: (_, __) => lottie.Lottie.asset(
            'lib/asseets/60.json',
            width: 800,
            height: 800,
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
    print("Markers Count In Map Controller : ${markers.length}");
    update();
  }


  setCoordinate1() {
    firstMarker = LatLng(
      double.parse(latController1.text),
      double.parse(longController1.text),
    );
    print("firstMarker");
    markers.add(
       AnimatedMarker(
          point: firstMarker!,
          builder: (_, __) => lottie.Lottie.asset(
            'lib/asseets/60.json',
            width: 800,
            height: 800,
          ),
        ),

    );
    print("firstMarker $firstMarker");
    update();
  }

  setCoordinate2() {
    secondMarker = LatLng(
      double.parse(latController2.text),
      double.parse(longController2.text),
    );
    markers.add(
      AnimatedMarker(
          point: secondMarker!,
          builder: (_, __) => lottie.Lottie.asset(
            'lib/asseets/60.json',
            width: 800,
            height: 800,
          ),
        ),
    );
    print("secondMarker $secondMarker");
    update();
  }

  void clearMarkers() {
    markers.clear();
    firstMarker = null;
    secondMarker = null;
    print("Cleared");
    update();
  }

  void updateMap(String mapStyle) {
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
