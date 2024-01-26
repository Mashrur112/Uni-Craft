import 'package:flutter/material.dart';

class PassRes extends StatefulWidget {
  final result;

  const PassRes({Key? key, required this.result}) : super(key: key);

  @override
  State<PassRes> createState() => _PassResState();
}

class _PassResState extends State<PassRes> {
  // Method to return the result
  dynamic pass() {
    return widget.result;
  }

  @override
  Widget build(BuildContext context) {
    // You can use the result directly in the build method
    // or use the pass() method if needed elsewhere
    return widget.result;
  }
}
