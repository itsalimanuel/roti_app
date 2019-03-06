import 'package:flutter/material.dart';

class ProgressDialog extends StatelessWidget {
  final Color backgroundColor;
  final Color color;
  final Color containerColor;
  final double borderRadius;
  final String text;

  ProgressDialog(
      {Key key,
        this.backgroundColor = Colors.black54,
        this.color = Colors.white,
        this.containerColor = Colors.transparent,
        this.borderRadius = 10.0,
        this.text
      }) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withAlpha(200),
      child: Center(
        child: new Container(
          padding: const EdgeInsets.all(30.0),
          child: new GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: new Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new CircularProgressIndicator(),
                  new SizedBox(
                    height: 15.0,
                  ),
                  new Text(
                    "please wait..",
                    style: new TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
