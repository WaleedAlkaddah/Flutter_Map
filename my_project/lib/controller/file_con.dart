import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:my_project/controller/excel_con1.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import '../waleed_widget/flutter_toast.dart';

class FileController extends GetxController {
  final TextEditingController fileNameReadController = TextEditingController();
  final TextEditingController fileNameWriteController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  String filePath = "";
  String content = " ";
  static Future<bool> requestStoragePermission() async {
    // OS or above 13 is Permission.manageExternalStorage.request();
    // OS Under 13 is Permission.storage.request()
    final result = await Permission.manageExternalStorage.request();
    return result.isGranted;
  }

  Future<void> writeToFile(String fileName, String content) async {
    if (await requestStoragePermission()) {
      filePath =
          await ExcelController1().getExternalStorageDirectoryFunc(fileName);
      File file = File(filePath);
      String oldContent = await readFromFile(fileName);
      String newContent = "$oldContent\n$content";
      await file.writeAsString(newContent);
      print("File written successfully: $filePath");
      FlutterToastWidget.buildFlutterToast(
          "File written successfully: $filePath");
    } else {
      print("Storage permission is not granted");
      FlutterToastWidget.buildFlutterToast("Storage permission is not granted");
    }
    update();
  }

  Future<String> readFromFile(String fileName) async {
    if (await requestStoragePermission()) {
      filePath =
          await ExcelController1().getExternalStorageDirectoryFunc(fileName);
      try {
        File file = File(filePath);
        content = await file.readAsString();
        FlutterToastWidget.buildFlutterToast("Read From File");
        update();
        return content;
      } catch (e) {
        return "";
      }
    } else {
      FlutterToastWidget.buildFlutterToast("Storage permission is not granted");
      print("Storage permission is not granted");
      update();
      return "Storage permission not granted";
    }
  }

  void onPressedRead() async {
    print("------------------------------------------------");
    print("onPressedRead");
    String content = await readFromFile(fileNameReadController.text);
    print("$content");
    update();
  }

  void onPressedWrite() async {
    print("------------------------------------------------");
    print("onPressedWrite");
    await writeToFile(fileNameWriteController.text, contentController.text);
    update();
  }
}
