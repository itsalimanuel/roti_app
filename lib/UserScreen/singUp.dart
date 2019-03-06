import 'package:flutter/material.dart';
import 'package:roti_app/tools/app_data.dart';
import 'package:roti_app/tools/app_method.dart';
import 'package:roti_app/tools/app_tools.dart';
import 'package:roti_app/tools/firebase_method.dart';

class SingUp extends StatefulWidget {
  @override
  _SingUpState createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController re_password = new TextEditingController();
  TextEditingController fullname = new TextEditingController();
  TextEditingController phone = new TextEditingController();
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
        title: new Text("Register"),
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
                textHint: "Full name",
                textIcon: Icons.person,
                controller: fullname),
            new SizedBox(
              height: 30.0,
            ),
            appTextField(
                isPassword: false,
                sidePadding: 18.0,
                textHint: "Phone Number",
                textIcon: Icons.phone,
                textType: TextInputType.number,
                controller: phone),
            new SizedBox(
              height: 30.0,
            ),
            appTextField(
                isPassword: false,
                sidePadding: 18.0,
                textHint: "Email address",
                textIcon: Icons.email,
                textType: TextInputType.emailAddress,
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
            new SizedBox(
              height: 30,
            ),
            appTextField(
                isPassword: true,
                sidePadding: 18.0,
                textHint: "Re-Password",
                textIcon: Icons.lock,
                controller: re_password),
            appButton(
                btnTxt: "Create Account",
                onBtnClick: verifyRegister,
                btnPadding: 20.0,
                btnColor: Theme.of(context).primaryColor),
          ],
        ),
      ),
    );
  }

  verifyRegister() async{
    if (fullname.text == "") {
      showSnackbar("Email conno't be empty", scaffoldKey);
      return;
    }
    if (phone.text == "") {
      showSnackbar("Write your phone", scaffoldKey);
      return;
    }
    if (email.text == "") {
      showSnackbar("Write your email", scaffoldKey);
      return;
    }
    if (password.text == "") {
      showSnackbar("Write your password", scaffoldKey);
      return;
    }
    if (re_password.text == "") {
      showSnackbar("Write your Re-Password", scaffoldKey);
      return;
    }

    if (password.text != re_password.text) {
      showSnackbar("the password not the same", scaffoldKey);
      return;
    }

    displayProgressDialog(context);
    String response = await appMethod.createUserAccount(
        fullname: fullname.text,
        phone: phone.text,
        email: email.text.toLowerCase(),
        password: password.text.toLowerCase());
    if (response == successful) {
      closeProgressDialog(context);
      Navigator.of(context).pop();
      Navigator.of(context).pop(true);
    } else {
      closeProgressDialog(context);
      showSnackbar(response, scaffoldKey);
    }
  }
}
