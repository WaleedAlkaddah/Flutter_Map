import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart' as lottie;
import '../controller/map_con.dart';
import '../controller/search_con.dart';
import '../model/serach_mod.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';

class MapScreen extends StatefulWidget {
  MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with TickerProviderStateMixin {
  final Map_Controller controller = Get.find<Map_Controller>();
  final AddressController addressController = Get.find<AddressController>();
  late final _mapController = AnimatedMapController(
    vsync: this,
    duration: const Duration(seconds: 10),
  );

  Widget TypeButtons(String url, String name) {
    return ElevatedButton(
      onPressed: () => controller.updateMap(url),
      child: Text(name),
    );
  }

  // ignore: non_constant_identifier_names
  Widget Text_Field(TextEditingController Controller, String Text) {
    return Expanded(
      child: TextField(
        controller: Controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(labelText: Text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Two Markers'),
          actions: [
            GetBuilder<Map_Controller>(
              builder: (controller) {
                return OutlinedButton(
                  onPressed: () {
                    controller.clearMarkers();
                    addressController.showCustomMarkers = false;
                  },
                  child: const Text(
                    "Clear Markers",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Text_Field(controller.latController1, 'Latitude 1'),
                  const SizedBox(width: 10),
                  Text_Field(controller.longController1, 'Longitude 1'),
                ],
              ),
              GetBuilder<Map_Controller>(builder: (controller) {
                return ElevatedButton(
                  onPressed: () {
                    controller.setCoordinate1();
                    _mapController.animateTo(
                        dest: controller.firstMarker,
                        zoom: 15.0,
                        rotation: 15.0,
                        curve: Curves.easeIn);
                  },
                  child: const Text('Set Coordinate 1'),
                );
              }),
              Row(
                children: [
                  Text_Field(controller.latController2, 'Latitude 2'),
                  const SizedBox(width: 10),
                  Text_Field(controller.longController2, 'Longitude 2'),
                ],
              ),
              GetBuilder<Map_Controller>(builder: (controller) {
                return ElevatedButton(
                  onPressed: () {
                    controller.setCoordinate2();
                    _mapController.animateTo(
                        dest: controller.secondMarker,
                        zoom: 15.0,
                        rotation: 15.0,
                        curve: Curves.easeIn);
                  },
                  child: const Text('Set Coordinate 2'),
                );
              }),
              GetBuilder<Map_Controller>(builder: (controller) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TypeButtons(controller.defultmap, 'Default Map'),
                    TypeButtons(controller.satellite_map, 'Satellite Map'),
                    TypeButtons(controller.terrain_map, 'Terrain Map'),
                  ],
                );
              }),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: addressController.TextaddressController,
                  decoration: const InputDecoration(labelText: 'Enter Address'),
                ),
              ),
              GetBuilder<AddressController>(builder: (controller) {
                return ElevatedButton(
                  onPressed: () async {
                    await controller.getAddressInfo();
                    setState(() {
                      addressController.showCustomMarkers = true;
                    });
                    _mapController.animateTo(
                        dest: addressController.latLng1,
                        zoom: 15.0,
                        rotation: 15.0,
                        curve: Curves.easeIn);
                  },
                  child: const Text('Serach'),
                );
              }),
              const SizedBox(height: 10),
              SizedBox(
                height: 500,
                child: GetBuilder<Map_Controller>(
                  builder: (controller1) {
                    print("MapScreen Count: ${controller1.markers.length}");
                    print("MapScreen Rebuilt");
                    return FlutterMap(
                      mapController: _mapController,
                      options: MapOptions(
                          center: LatLng(0, 0),
                          zoom: 2.0,
                          onTap: (tapPosition, point) {
                            controller1.handleTap(tapPosition, point);
                            _mapController.animateTo(
                                dest: point,
                                zoom: 15.0,
                                rotation: 15.0,
                                curve: Curves.easeIn);
                            print(" _mapController.animateTo");
                          }),
                      children: [
                        TileLayer(
                          urlTemplate: controller1.defultmap,
                          subdomains: ['a', 'b', 'c'],
                        ),
                        AnimatedMarkerLayer(
                          markers: addressController.showCustomMarkers
                              ? [
                                  AnimatedMarker(
                                    point: LatLng(
                                        addressController.latitude.value,
                                        addressController.longitude.value),
                                    builder: (_, __) => lottie.Lottie.asset(
                                      'lib/asseets/60.json',
                                      width: 800,
                                      height: 800,
                                    ),
                                  ),
                                ]
                              : controller1.markers,
                        ),
                        PolylineLayer(
                          polylines: [
                            if (controller1.firstMarker != null &&
                                controller1.secondMarker != null)
                              Polyline(points: [
                                controller1.firstMarker!,
                                controller1.secondMarker!,
                              ], strokeWidth: 2.0, color: Colors.black),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: GetBuilder<Map_Controller>(
          builder: (controller) {
            return controller.markers.length == 2
                ? FloatingActionButton(
                    onPressed: controller.calculateDistance,
                    child: const Icon(Icons.calculate),
                  )
                : const SizedBox.shrink();
          },
        ));
  }
}
