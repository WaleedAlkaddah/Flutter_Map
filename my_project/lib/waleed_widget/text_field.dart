import 'package:flutter/material.dart';


class TextFild extends StatelessWidget {
  final TextEditingController controller;
  final String text;

  const TextFild({
    Key? key,
    required this.controller,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 180,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(labelText: text),
      ),
    );
  }
}
