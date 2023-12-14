
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/binding/map_bind.dart';
import 'package:my_project/view/map_view.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
     getPages: [
      GetPage(name: "/", page: ()=> MapScreen() , binding: MapBinding())
     ],
     debugShowCheckedModeBanner: false,
    );
  }
}




















/*
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapController mapController = MapController();
  LatLng? tappedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Map Example'),
      ),
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
            center: LatLng(0, 0),
            zoom: 2.0,
            onTap: (tapPosition, Point) {
              _handleTap(Point);
            }),
        layers: [
          TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayerOptions(
            markers: [
              if (tappedLocation != null)
                Marker(
                  width: 30.0,
                  height: 30.0,
                  point: tappedLocation!,
                  builder: (ctx) => Container(
                    child: Icon(
                      Icons.location_on,
                      color: Colors.red,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  void _handleTap(LatLng latlng) {
    setState(() {
      tappedLocation = latlng;
      mapController.move(latlng, 15.0);
    });
  }
}
*/

/*
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapController mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Map Zoom Animation'),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(0, 0),
          zoom: 2.0,
          onTap: (tapPosition,point) {
            mapController.move(point, 10.0);
          },
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
        ],
        mapController: mapController,
      ),
    );
  }
}
*/




/*
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Map Example',
      home: MapScreen(),
    );
  }
}

class AddressModel {
  late String address;
  late double latitude;
  late double longitude;

  AddressModel(
      {required this.address, required this.latitude, required this.longitude});

  Future<void> getAddressInfo(String query) async {
    String apiUrl =
        'https://nominatim.openstreetmap.org/search?format=json&q=$query';
    var response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data != null && data.isNotEmpty) {
        latitude = double.parse(data[0]['lat']);
        longitude = double.parse(data[0]['lon']);
      }
    }
  }
}

class AddressController extends GetxController {
  var addressController = TextEditingController();
  var address = "".obs;
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;

  Future<void> getAddressInfo() async {
    var model = AddressModel(address: "", latitude: 0.0, longitude: 0.0);
    await model.getAddressInfo(addressController.text);
    address.value = model.address;
    latitude.value = model.latitude;
    longitude.value = model.longitude;
    update();
  }
}

class MapScreen extends StatelessWidget {
  final AddressController addressController = Get.put(AddressController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Example'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: addressController.addressController,
              decoration: InputDecoration(labelText: 'Enter Address'),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await addressController.getAddressInfo();
            },
            child: Text('Get Address Info'),
          ),
          Expanded(
            child: GetBuilder<AddressController>(
              builder: (controller) {
                return FlutterMap(
                  options: MapOptions(
                    center: LatLng(
                        controller.latitude.value, controller.longitude.value),
                    zoom: 2.0,
                  ),
                  layers: [
                    TileLayerOptions(
                      urlTemplate:
                          'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: ['a', 'b', 'c'],
                    ),
                    MarkerLayerOptions(
                      markers: [
                        Marker(
                          width: 40.0,
                          height: 40.0,
                          point: LatLng(controller.latitude.value,
                              controller.longitude.value),
                          builder: (ctx) => Container(
                            child: Icon(
                              Icons.location_pin,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

*/



/*
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapType _currentMapType = MapType.standard;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Switcher'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FlutterMap(
              options: MapOptions(
                center: LatLng(51.5, -0.09),
                zoom: 13.0,
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate: _getTileProvider(),
                  subdomains: ['a', 'b', 'c'],
                  tileProvider: NonCachingNetworkTileProvider(),
                ),
              ],
            ),
          ),
          _buildMapTypeButtons(),
        ],
      ),
    );
  }

  String _getTileProvider() {
    switch (_currentMapType) {
      case MapType.satellite:
        return "https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}";
      case MapType.terrain:
        return "https://stamen-tiles.a.ssl.fastly.net/terrain/{z}/{x}/{y}.jpg";
      default:
        return "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png";
    }
  }

  Widget _buildMapTypeButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () => _changeMapType(MapType.standard),
          child: Text('Standard Map'),
        ),
        ElevatedButton(
          onPressed: () => _changeMapType(MapType.satellite),
          child: Text('Satellite Map'),
        ),
        ElevatedButton(
          onPressed: () => _changeMapType(MapType.terrain),
          child: Text('Terrain Map'),
        ),
      ],
    );
  }

  void _changeMapType(MapType newMapType) {
    setState(() {
      _currentMapType = newMapType;
    });
  }
}

enum MapType {
  standard,
  satellite,
  terrain,
}
*/

/*
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coordinate Map App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _latitudeController1 = TextEditingController();
  TextEditingController _longitudeController1 = TextEditingController();
  TextEditingController _latitudeController2 = TextEditingController();
  TextEditingController _longitudeController2 = TextEditingController();

  LatLng? coordinate1;
  LatLng? coordinate2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coordinate Map App'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _latitudeController1,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Latitude 1'),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _longitudeController1,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Longitude 1'),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                coordinate1 = LatLng(
                  double.parse(_latitudeController1.text),
                  double.parse(_longitudeController1.text),
                );
              });
            },
            child: Text('Set Coordinate 1'),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _latitudeController2,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Latitude 2'),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _longitudeController2,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Longitude 2'),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                coordinate2 = LatLng(
                  double.parse(_latitudeController2.text),
                  double.parse(_longitudeController2.text),
                );
              });
            },
            child: Text('Set Coordinate 2'),
          ),
          SizedBox(height: 20),
          Expanded(
            child: FlutterMap(
              options: MapOptions(
                center: LatLng(0, 0),
                zoom: 2.0,
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
                if (coordinate1 != null)
                  MarkerLayerOptions(
                    markers: [
                      Marker(
                        width: 30.0,
                        height: 30.0,
                        point: coordinate1!,
                        builder: (ctx) => Container(
                          child: Icon(
                            Icons.place,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                if (coordinate2 != null)
                  MarkerLayerOptions(
                    markers: [
                      Marker(
                        width: 30.0,
                        height: 30.0,
                        point: coordinate2!,
                        builder: (ctx) => Container(
                          child: Icon(
                            Icons.place,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
*/

/*
// يتحرك مكان ما حدد
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Map Zoom Demo',
      home: MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapController mapController = MapController();
  LatLng? selectedPoint;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Zoom Demo'),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(0, 0),
          zoom: 2.0,
          onTap: (tapPosition, latLng) => _handleTap(latLng),
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          if (selectedPoint != null)
            MarkerLayerOptions(
              markers: [
                Marker(
                  width: 30.0,
                  height: 30.0,
                  point: selectedPoint!,
                  builder: (ctx) => Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
              ],
            ),
        ],
        mapController: mapController,
      ),
    );
  }

  void _handleTap(LatLng point) {
    setState(() {
      selectedPoint = point;
    });
    _zoomToPoint(point);
  }

  void _zoomToPoint(LatLng point) {
    mapController.move(point, 15.0);
  }
}*/
