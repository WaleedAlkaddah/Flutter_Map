import 'package:get/get.dart';
import '../controller/map_con.dart';
import '../controller/search_con.dart';

class MapBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Map_Controller>(() => Map_Controller());
    Get.lazyPut<AddressController>(() => AddressController());
  }
}
