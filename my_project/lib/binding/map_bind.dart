import 'package:get/get.dart';
import '../controller/map_con.dart';
import '../controller/search_con.dart';

class MapBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<Map_Controller>(Map_Controller());
    Get.put<AddressController>(AddressController());
  }
}
