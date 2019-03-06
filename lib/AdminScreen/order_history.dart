import 'package:flutter/material.dart';
import 'package:roti_app/tools/app_tools.dart';



class SearchHistory extends StatefulWidget {
  @override
  _SearchHistoryState createState() => _SearchHistoryState();
}

class _SearchHistoryState extends State<SearchHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Search Data"),
        centerTitle: false,
      ),
      body: new Column(
        children: <Widget>[
          SizedBox(height: 15.0,),
          productTextField(
            titleText: "Add you address",textHint: "Russia-Moscow"
          ),
          SizedBox(height: 10.0,),
        ],
      ),
    );
  }
}
