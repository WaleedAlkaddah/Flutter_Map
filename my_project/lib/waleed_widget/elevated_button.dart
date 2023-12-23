import 'package:flutter/material.dart';

import '../controller/map_con.dart';

class ElevatedBtn extends StatelessWidget {
  final String url;
  final String name;
  final Map_Controller controller;

  const ElevatedBtn({
    super.key,
    required this.url,
    required this.name,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => controller.updateMap(url),
      child: Text(name),
    );
  }
}
