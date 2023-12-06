import 'package:get/get.dart';
import '../controller/map_con.dart';

class MapBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<MapController>(MapController());
  }
}
