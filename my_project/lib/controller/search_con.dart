import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:my_project/controller/map_con.dart';
import '../model/serach_mod.dart';
import 'package:flutter/material.dart';
import '../waleed_widget/animated_marker.dart';

class AddressController extends GetxController {
  final TextEditingController textAddressController = TextEditingController();
  Map_Controller mapController = new Map_Controller();
  var address = "".obs;
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  LatLng? latLng1;
  bool showCustomMarkers = false;

  Future<void> getAddressInfo() async {
    var model = AddressModel(address: "", latitude: 0.0, longitude: 0.0);
    print("Address :");
    print(textAddressController.text);
    await model.getAddressInfo(textAddressController.text);
    address.value = model.address;
    latitude.value = model.latitude;
    longitude.value = model.longitude;
    latLng1 = LatLng(latitude.value, longitude.value);
    mapController.markers.add(
      AnimatedMark.buildAnimatedMarker(latLng1!, 'lib/asseets/60.json'),
    );
    print("Markers Count: ${mapController.markers.length}");
    print("Stored");
    update();
  }
}
