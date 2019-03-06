import 'package:flutter/material.dart';



class FindUser extends StatefulWidget {
  @override
  _FindUserState createState() => _FindUserState();
}

class _FindUserState extends State<FindUser> {
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
