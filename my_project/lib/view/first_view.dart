import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/view/map_view.dart';
import 'package:my_project/view/read_write_file.dart';
import '../binding/file_bind.dart';
import '../binding/map_bind.dart';
import '../text/text.dart';

class FirstView extends StatefulWidget {
  const FirstView({Key? key}) : super(key: key);

  @override
  State<FirstView> createState() => _FirstViewState();
}

class _FirstViewState extends State<FirstView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text(TextView.first),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Get.to(() => MapScreen(), binding: MapBinding());
              },
              child: const Text(TextView.map),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Get.to(() => ReadWriteFile(),binding: FileBinding());
              },
              child: const Text(TextView.file),
            ),
          ],
        ),
      ),
    );
  }
}
