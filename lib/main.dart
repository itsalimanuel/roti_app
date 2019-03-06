import 'dart:async';

import 'package:flutter/material.dart';

// import the another page
import 'LoginPage.dart';
// start codeing

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {



  static const appColors = ColorSwatch(0xFF991155, {
    "appColor": Color(0xFF991155),
    100: Color(0xFFff1d8e),
    200: Color(0xFFe51a7f),
    300: Color(0xFFcc1771),
    400: Color(0xFFb21463),
    500: Color(0xFF991155),
    600: Color(0xFF7f0e47),
    700: Color(0xFF660b38),
    800: Color(0xFF4c082a),
    900: Color(0xFF33051c),
    1000: Color(0xFF19020e),
    0000: Color(0xFF000000),
  });



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String,WidgetBuilder>{
        '/LoginPage': (BuildContext context) =>LoginScreen(),
      },
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  startTime() async {
    var _duration = new Duration(seconds: 5);
    return Timer(_duration,navigationPage);
  }

  void navigationPage(){
    Navigator.of(context).pushReplacementNamed("/LoginPage");
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("background.png"),
      ),
    );
  }
}