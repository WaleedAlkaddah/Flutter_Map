import 'package:flutter/material.dart';

class TextFieldModified extends StatelessWidget {
  final TextEditingController? controller;
  final String? text;
  final void Function(String)? onChanged;
  final InputBorder? border;

  const TextFieldModified({
    Key? key,
    this.controller,
    this.text,
    this.onChanged,
    this.border,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: text,
          border: border,
        ),
      ),
    );
  }
}
