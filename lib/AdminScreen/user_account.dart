import 'package:flutter/material.dart';
import 'package:roti_app/tools/app_tools.dart';

class UserAccount extends StatefulWidget {
  @override
  _UserAccountState createState() => _UserAccountState();
}

class _UserAccountState extends State<UserAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
        appBar: new AppBar(
          backgroundColor: Colors.greenAccent,
          title: new Text("Search Data"),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: new SingleChildScrollView(
          child: new Column(
            children: <Widget>[
              new SizedBox(height: 20.0,),
              productTextField(
                titleText: "Product Title",textHint: "Enter Product Text"
              ),
              new SizedBox(
                height: 20.0,
              ),
              productTextField(
                titleText: "Description",
                textHint: "Enter your Description",
                height: 100.0
              )
            ],
          ),
        ));
  }
}
