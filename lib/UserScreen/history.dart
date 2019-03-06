import 'package:flutter/material.dart';


class RotiHistory extends StatefulWidget {
  _RotiHistoryState createState() => _RotiHistoryState();
}

class _RotiHistoryState extends State<RotiHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("My History"),
        centerTitle: true,
      ),
    );
  }
}