import 'package:get/get.dart';
import 'package:my_project/controller/file_con.dart';

class FileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FileController>(() => FileController());
  }
}
