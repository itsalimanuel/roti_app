import 'package:flutter/material.dart';

class RotiAddress extends StatefulWidget {
  _RotiAddressState createState() => _RotiAddressState();
}

class _RotiAddressState extends State<RotiAddress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("My Address"),
        centerTitle: true,
      ),
    );
  }
}