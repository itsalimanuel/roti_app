import 'package:flutter/material.dart';



class UserOrder extends StatefulWidget {
  @override
  _UserOrderState createState() => _UserOrderState();
}

class _UserOrderState extends State<UserOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Search Data"),
        centerTitle: false,
      ),
      body: new Center(
        child: new Text("User Order",style: new TextStyle(fontSize: 25.0),),

      ) ,
    );
  }
}
