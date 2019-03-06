import 'package:flutter/material.dart';
import 'package:roti_app/UserScreen/singUp.dart';
import 'package:roti_app/tools/app_data.dart';
import 'package:roti_app/tools/app_method.dart';
import 'package:roti_app/tools/app_tools.dart';
import 'package:roti_app/tools/firebase_method.dart';

class RotiLogin extends StatefulWidget {
  _RotiLoginState createState() => _RotiLoginState();
}

class _RotiLoginState extends State<RotiLogin> {
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  BuildContext context;
  AppMethods appMethod = new FirebaseMethods();

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: new AppBar(
        title: new Text("Login"),
        centerTitle: false,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            new SizedBox(
              height: 30.0,
            ),
            appTextField(
                isPassword: false,
                sidePadding: 18.0,
                textHint: "Email address",
                textIcon: Icons.email,
                controller: email),
            new SizedBox(
              height: 30.0,
            ),
            appTextField(
                isPassword: true,
                sidePadding: 18.0,
                textHint: "Password",
                textIcon: Icons.lock,
                controller: password),
            appButton(
                btnTxt: "Login",
                onBtnClick: verifyLogin,
                btnPadding: 20.0,
                btnColor: Theme.of(context).primaryColor),
            new GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    new MaterialPageRoute(builder: (context) => new SingUp()));
              },
              child: new Text(
                "Don't have ? Register now",
                style: new TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }

  verifyLogin() async {
    if (email.text == "") {
      showSnackbar("Email conno't be empty", scaffoldKey);
      return;
    }
    if (password.text == "") {
      showSnackbar("Write your password", scaffoldKey);
      return;
    }

    displayProgressDialog(context);
    String response = await appMethod.logginUser(
        email: email.text.toLowerCase(), password: password.text.toLowerCase());
    if (response == successful) {
      closeProgressDialog(context);
      Navigator.of(context).pop(true);
    } else {
      closeProgressDialog(context);
      showSnackbar(response, scaffoldKey);
    }
  }
}
