import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class FileController extends GetxController {
  final TextEditingController fileNameReadController = TextEditingController();
  final TextEditingController fileNameWriteController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  Future<void> writeToFile(String fileName, String content) async {
    if (await Permission.storage.request().isGranted) {
      Directory appDocumentsDirectory =
          await getApplicationDocumentsDirectory();
      String filePath = "${appDocumentsDirectory.path}/$fileName";
      File file = File(filePath);
      String oldContent = await readFromFile(fileName);
      String newContent = "$oldContent\n$content";
      await file.writeAsString(newContent);
      print("File written successfully: $filePath");
    } else {
      print("Storage permission is not granted");
    }
    update();
  }

  Future<String> readFromFile(String fileName) async {
    if (await Permission.storage.request().isGranted) {
      Directory appDocumentsDirectory =
          await getApplicationDocumentsDirectory();
      String filePath = "${appDocumentsDirectory.path}/$fileName";
      try {
        File file = File(filePath);
        String content = await file.readAsString();
        update();
        return content;
      } catch (e) {
        return "";
      }
    } else {
      print("Storage permission is not granted");
      update();
      return "Storage permission not granted";
    }
  }

  void onPressedRead() async {
    String content = await readFromFile(fileNameReadController.text);
    print("$content");
    update();
  }

  void onPressedWrite() async {
    await writeToFile(fileNameWriteController.text, contentController.text);
    update();
  }
}
