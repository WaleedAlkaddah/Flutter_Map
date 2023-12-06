import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:get/get.dart';
import 'package:my_project/controller/map_con.dart' as myProjectController;

class MapScreen extends StatefulWidget {
  MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  
  final myProjectController.MapController controller =
      Get.find<myProjectController.MapController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Two Markers'),
          actions: [
            GetBuilder<myProjectController.MapController>(
              builder: (controller) {
                return OutlinedButton(
                  onPressed: controller.clearMarkers,
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
        body: GetBuilder<myProjectController.MapController>(
          builder: (controller) {
            return FlutterMap(
              options: MapOptions(
                center: LatLng(0, 0),
                zoom: 2.0,
                onTap: controller.handleTap,
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayerOptions(
                  markers: controller.markers,
                ),
              ],
            );
          },
        ),
        floatingActionButton: GetBuilder<myProjectController.MapController>(
          builder: (controller) {
            return controller.markers.length == 2
                ? FloatingActionButton(
                    onPressed: controller.calculateDistance,
                    child: Icon(Icons.calculate),
                  )
                : SizedBox.shrink();
          },
        ));
  }
}



