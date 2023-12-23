import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:my_project/controller/map_con.dart';
import '../model/serach_mod.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart' as lottie;
import '../waleed_widget/animated_marker.dart';

class AddressController extends GetxController {
  var TextaddressController = TextEditingController();
  Map_Controller mapController = new Map_Controller();
  var address = "".obs;
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  LatLng? latLng1;
  bool showCustomMarkers = false;
  AnimatedMark animatedmarker = AnimatedMark();

  Future<void> getAddressInfo() async {
    var model = AddressModel(address: "", latitude: 0.0, longitude: 0.0);
    print("Address :");
    print(TextaddressController.text);
    await model.getAddressInfo(TextaddressController.text);
    address.value = model.address;
    latitude.value = model.latitude;
    longitude.value = model.longitude;
    latLng1 = LatLng(latitude.value, longitude.value);
    mapController.markers.add(
      animatedmarker.buildAnimatedMarker(latLng1!, 'lib/asseets/60.json'),
    );
    print("Markers Count: ${mapController.markers.length}");
    print("Stored");
    update();
  }
}
