import 'package:flutter/material.dart';
import 'UserScreen/myHomePage.dart';

void main(){
  runApp(Login());
}
class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new GirliesApp(),
    );
  }
}
class LoginScreen extends StatefulWidget {
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return new GirliesApp();
  }
}