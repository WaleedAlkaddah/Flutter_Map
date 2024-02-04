import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'package:get/get.dart';
import '../controller/file_con.dart';
import '../waleed_widget/flutter_toast.dart';

class ExcelController1 extends GetxController {
  final TextEditingController fileNameWriteController = TextEditingController();
  final TextEditingController rowsController = TextEditingController();
  final TextEditingController columnsController = TextEditingController();
  int rows = 0;
  int columns = 0;
  bool updateCheck = false;
  String filePath = "";
  List<List<String>> tableData = [];
  List<List<String>> data = List.generate(2, (index) => List.filled(2, ""));
  List<List<dynamic>> dataUpdate =
      List.generate(2, (index) => List.filled(2, ""));

  Future<String> getExternalStorageDirectoryFunc(String controllerName) async {
    // OS or above 13 is getExternalStorageDirectory();
    // OS Under 13 is getApplicationDocumentsDirectory();
    Directory? appDocumentsDirectory = await getExternalStorageDirectory();
    filePath = '${appDocumentsDirectory!.path}/$controllerName';
    return filePath;
  }

  Future<void> createExcel() async {
    print("File name createExcel : ${fileNameWriteController.text}");
    if (await FileController.requestStoragePermission()) {
      Excel excel = Excel.createExcel();
      filePath =
          await getExternalStorageDirectoryFunc(fileNameWriteController.text);
      var file = await File(filePath).create();
      await file.writeAsBytes(excel.encode()!);
      print('Excel file created successfully. $filePath');
      FlutterToastWidget.buildFlutterToast(
          'Excel file created successfully. $filePath');
      update();
    } else {
      FlutterToastWidget.buildFlutterToast("Storage permission is not granted");
      print("Storage permission is not granted");
      update();
    }
  }

  void deleteExcel() async {
    try {
      if (await FileController.requestStoragePermission()) {
        filePath =
            await getExternalStorageDirectoryFunc(fileNameWriteController.text);
        print("deleteExcel() : $filePath");
        if (await File(filePath).exists()) {
          await File(filePath).delete();
          print("Excel file deleted successfully");
          fileNameWriteController.text = '';
          rowsController.text = '';
          columnsController.text = '';
          rows = 0;
          columns = 0;
          data.clear();
          tableData.clear();
          dataUpdate.clear();
          FlutterToastWidget.buildFlutterToast(
              "Excel file deleted successfully");
        } else {
          print("Excel file not found");
          FlutterToastWidget.buildFlutterToast("Excel file not found");
        }
        update();
      } else {
        FlutterToastWidget.buildFlutterToast(
            "Storage permission is not granted");
        print("Storage permission is not granted");
        update();
      }
    } catch (e) {
      print("Error deleting Excel file: $e");
      FlutterToastWidget.buildFlutterToast("Error deleting Excel file: $e");
    }
  }

  void displayTable() {
    rows = int.tryParse(rowsController.text) ?? 0;
    data = List.generate(rows, (index) => List.filled(columns, ""));
    columns = int.tryParse(columnsController.text) ?? 0;
    data = List.generate(rows, (index) => List.filled(columns, ""));
    print("Rows Number : $rows , Columns Numbers : $columns");
    update();
  }

  void appendData() async {
    try {
      if (await FileController.requestStoragePermission()) {
        filePath =
            await getExternalStorageDirectoryFunc(fileNameWriteController.text);
        var file = filePath;
        var bytes = File(file).readAsBytesSync();
        var excel = Excel.decodeBytes(bytes);
        var sheet = excel['Sheet1'];
        for (var row in data) {
          sheet.appendRow(row);
        }
        var newFile = filePath;
        var newBytes = excel.save();
        File(newFile).createSync(recursive: true);
        File(newFile).writeAsBytesSync(newBytes!);
        print(data);
        FlutterToastWidget.buildFlutterToast('Data Appended');
        update();
      } else {
        FlutterToastWidget.buildFlutterToast(
            "Storage permission is not granted");
        print("Storage permission is not granted");
        update();
      }
    } catch (e) {
      print("Error : $e");
    }
  }

  Future<void> readExcel() async {
    tableData.clear();
    filePath =
        await getExternalStorageDirectoryFunc(fileNameWriteController.text);
    var bytes = File(filePath).readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);
    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table]!.rows) {
        tableData
            .add(List<String>.from(row.map((cell) => cell?.value.toString())));
      }
    }
    print(tableData);
    update();
  }

  void updateCell() async {
    try {
      filePath =
          await getExternalStorageDirectoryFunc(fileNameWriteController.text);
      print("------------------------");
      print("updateCell : $filePath");
      print(dataUpdate);
      var bytes = File(filePath).readAsBytesSync();
      var excel = Excel.decodeBytes(bytes);
      var sheet = excel["Sheet1"];
      for (int i = 0; i < dataUpdate.length; i++) {
        for (int j = 0; j < dataUpdate[i].length; j++) {
          dynamic value = dataUpdate[i][j];
          if (value is String && value.isNotEmpty) {
            var cell = sheet
                .cell(CellIndex.indexByColumnRow(columnIndex: j, rowIndex: i));
            print("Column : $j , row: $i");
            cell.value = dataUpdate[i][j];
            print("cell.value : ${cell.value}");
          }
        }
      }
      File(filePath)
        ..createSync(recursive: true)
        ..writeAsBytesSync(excel.encode()!);
      update();
    } catch (e) {
      print("Error $e");
    }
  }

  void callUpdateTable() {
    updateCheck = true;
    update();
  }
}
