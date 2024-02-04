import 'package:flutter/material.dart';

class ElevatedBtn extends StatelessWidget {
  final String url;
  final String name;
  final VoidCallback onPressedCall;
  const ElevatedBtn({
    Key? key,
    required this.url,
    required this.name,
    required this.onPressedCall,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressedCall,
      child: Text(name),
    );
  }
}
