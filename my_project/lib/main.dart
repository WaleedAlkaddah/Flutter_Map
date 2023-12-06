import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
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

