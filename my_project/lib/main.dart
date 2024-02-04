import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/view/first_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [GetPage(name: "/", page: () => const FirstView())],
      debugShowCheckedModeBanner: false,
    );
  }
}

/*
import 'dart:io';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  List<List<String>> tableData = [];

  Future<void> readExcel() async {
    tableData.clear();
    Directory? appDocumentsDirectory = await getExternalStorageDirectory();
    String filePath = '${appDocumentsDirectory!.path}/h.xlsx';
    var bytes = File(filePath).readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);

    for (var table in excel.tables.keys) {
      print(table); //sheet Name
      print(excel.tables[table]!.maxCols);
      print(excel.tables[table]!.maxRows);
      for (var row in excel.tables[table]!.rows) {
        tableData
            .add(List<String>.from(row.map((cell) => cell?.value.toString())));
      }
    }
    print(tableData);
  }

  void updateCell(String filePath, String sheetName, int column, int row,
      dynamic newValue) async {
    try {
      print("------------------------");
      print("updateCell : $filePath");
      // Read the file as bytes
      var bytes = File(filePath).readAsBytesSync();
      // Decode the bytes into an excel object
      var excel = Excel.decodeBytes(bytes);
      // Get the sheet object by name
      var sheet = excel[sheetName];
      // Get the cell object by index
      var cell = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: column, rowIndex: row));
      print("Column : $column , row: $row");
      // Update the cell value
      cell.value = newValue;
      print("cell.value : ${cell.value}");
      // Save the changes to the file

      File(filePath)
        ..createSync(recursive: true)
        ..writeAsBytesSync(excel.encode()!);
    } catch (e) {
      print("Error $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Excel Update Cell Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  Directory? appDocumentsDirectory =
                      await getExternalStorageDirectory();
                  String filePath = '${appDocumentsDirectory!.path}/h.xlsx';
                  String sheetName = 'Sheet1';
                  List<List<dynamic>> dataList = [
                    ['ma', 'na'],
                    ['wa', 'kaddah'],
                    [''],
                  ];

                  for (int i = 0; i < dataList.length; i++) {
                    for (int j = 0; j < dataList[i].length; j++) {
                      dynamic value = dataList[i][j];
                      if (value is String && value.isNotEmpty) {
                        updateCell(filePath, sheetName, j, i, dataList[i][j]);
                        //print('Non-empty string at row $i, column $j: $value');
                      }
                    }
                  }
                  /*
                  String sheetName =
                      'Sheet1'; // Change the sheet name if needed
                  int column =
                      1; // Replace with th e column index you want to update
                  int row = 0; // Replace with the row index you want to update
                  dynamic newValue = '1'; // Replace with the new value

                  */
                },
                child: Text('Update Excel Cell'),
              ),
              ElevatedButton(
                onPressed: () async {
                  readExcel();
                  /*
                  List<List<dynamic>> dataList = [
                    ['ma', 'na'],
                    ['wa', ''],
                    ['']
                  ];
                  for (int i = 0; i < dataList.length; i++) {
                    for (int j = 0; j < dataList[i].length; j++) {
                      dynamic value = dataList[i][j];
                      if (value is String && value.isNotEmpty) {
                        print('Non-empty string at row $i, column $j: $value');
                      }
                    }
                  }

                   */
                },
                child: Text('Read Excel Cell'),
              ),
              if (tableData.isEmpty)
                CircularProgressIndicator()
              else
                SizedBox(
                  height: 200,
                  width: 300,
                  child: ListView.builder(
                    itemCount: tableData.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(tableData[index].join(', ')),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

 */
