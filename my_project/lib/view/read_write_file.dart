import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import '../controller/file_con.dart';
import '../waleed_widget/text_field.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../text/text.dart';
import '../waleed_widget/elevated_button.dart';

class ReadWriteFile extends StatefulWidget {
  ReadWriteFile({Key? key}) : super(key: key);

  @override
  State<ReadWriteFile> createState() => _ReadWriteFileState();
}

class _ReadWriteFileState extends State<ReadWriteFile> {
  final FileController fileController = Get.find<FileController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FileController>(builder: (fileController) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(TextView.files),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFild(
                  controller: fileController.fileNameReadController,
                  text: TextView.readFile),
              ElevatedBtn(
                  url: "",
                  name: TextView.read,
                  onPressedCall: () => fileController.onPressedRead()),
              const Text(
                TextView.write,
                style: TextStyle(fontSize: 20),
              ),
              TextFild(
                  controller: fileController.fileNameWriteController,
                  text: TextView.nameFile),
              TextFild(
                  controller: fileController.contentController,
                  text: TextView.enterContent),
              const SizedBox(height: 16),
              ElevatedBtn(
                  url: "",
                  name: TextView.write,
                  onPressedCall: () => fileController.onPressedWrite()),
            ],
          ),
        ),
      );
    });
  }
}
