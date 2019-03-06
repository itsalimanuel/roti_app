import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:roti_app/main.dart';
import 'package:roti_app/tools/app_tools.dart';
import 'package:google_sign_in/google_sign_in.dart';

Map<int, String> myCriteria;

class RotiAboutus extends StatefulWidget {
  _RotiAboutusState createState() => _RotiAboutusState();
}

class _RotiAboutusState extends State<RotiAboutus> {
  BuildContext context;
  String fullName;
  String userEmail;
  String userPhone;
  String userID;
  String userPhoto;
  bool isLoggedIn;
  String _btnText;
  final googleSignIn = new GoogleSignIn();
  FirebaseUser user;
  FirebaseAuth auth;
  bool _isSignedIn;
  String aboutUs = " information about the app";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth = FirebaseAuth.instance;
    getCurrentUser();
  }

  getCurrentUser() async {
    user = await auth.currentUser().catchError((error) {
      print(error);
    });

    if (user != null) {
      setState(() {
        _btnText = "Logout";
        _isSignedIn = true;
        userEmail = user.email;
        fullName = user.displayName;
        userPhone = user.photoUrl;
      });
    }
  }

  void showInSnackBar(String value) {
    Scaffold.of(context).showSnackBar(new SnackBar(content: new Text(value)));
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    final Size screenSize = MediaQuery.of(context).size;
    return new Scaffold(
      backgroundColor: MyApp.appColors,
      appBar: new AppBar(
        title: new GestureDetector(
          onLongPress: () {},
          child: new Text(
            "About us",
            style: new TextStyle(color: Colors.white),
          ),
        ),
        centerTitle: false,
      ),
      resizeToAvoidBottomPadding: false,
      body: new Container(
        constraints: const BoxConstraints(maxHeight: 500.0),
        margin: new EdgeInsets.all(5.0),
        decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.all(new Radius.circular(20.0))),
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new SizedBox(
                height: 50.0,
                child: new Image.asset("girlies_text_colored.png"),
              ),
              new SizedBox(
                height: 50.0,
                child: new Image.asset("girlies_logo.png"),
              ),
              new Padding(
                padding: const EdgeInsets.all(2.0),
                child: new Text(
                  "version 2019",
                  style: new TextStyle(
                      fontSize: 14.0,
                      color: Colors.black26,
                      fontStyle: FontStyle.italic),
                ),
              ),
              new Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: new Text(
                    aboutUs,
                    style: new TextStyle(
                        fontSize: 15.0,
                        color: MyApp.appColors,
                        fontStyle: FontStyle.normal,
                        wordSpacing: 2.0),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget buildListItem(String title, IconData iconData, VoidCallback action) {
    final textStyle =
        new TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500);
    return new InkWell(
      onTap: action,
      child: new Padding(
        padding: const EdgeInsets.only(left: 10.0, bottom: 5.0, top: 5.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Container(
              width: 35.0,
              height: 35.0,
              margin: const EdgeInsets.only(right: 10.0),
              decoration: new BoxDecoration(
                color: MyApp.appColors[600],
                borderRadius: new BorderRadius.circular(5.0),
              ),
              alignment: Alignment.center,
              child: new Icon(
                iconData,
                color: Colors.white,
                size: 20.0,
              ),
            ),
            new Text(title, style: textStyle),
            new Expanded(child: new Container()),
            new IconButton(
                icon: new Icon(
                  Icons.chevron_right,
                  color: Colors.black26,
                ),
                onPressed: null)
          ],
        ),
      ),
    );
  }

  Widget buildAvatar() {
    final mainTextStyle = new TextStyle(
        fontFamily: "Timeburner",
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontSize: 20.0);
    final subTextStyle = new TextStyle(
        fontFamily: "Timeburner",
        fontSize: 16.0,
        color: Colors.white70,
        fontWeight: FontWeight.w500);

    return new Container(
      margin: new EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: new Row(
        children: <Widget>[
          new GestureDetector(
            child: new Container(
              width: 70.0,
              height: 70.0,
              margin: new EdgeInsets.only(left: 10.0),
              decoration: new BoxDecoration(
                image: new DecorationImage(
                    image: userPhoto != null
                        ? new NetworkImage(userPhoto)
                        : new NetworkImage(""),
                    fit: BoxFit.cover),
                borderRadius: new BorderRadius.all(new Radius.circular(50.0)),
                boxShadow: <BoxShadow>[
                  new BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5.0,
                      spreadRadius: 1.0),
                ],
              ),
            ),
          ),
          new Padding(padding: const EdgeInsets.only(right: 20.0)),
          new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(fullName != null ? fullName : fullName = " Your Name",
                  style: mainTextStyle),
              new Text(
                userEmail != null ? userEmail : userEmail = " Your Email",
                style: mainTextStyle,
              ),
              new Text(
                userPhone != null
                    ? userPhone
                    : userPhone = " Your Phone Number",
                style: mainTextStyle,
              ),
            ],
          )
        ],
      ),
    );
  }


  Future signOut() async {
    await auth.signOut();
    googleSignIn.signOut();
    showInSnackBar('user logged out');
    setState(() {
      _isSignedIn = false;
      fullName = null;
      userEmail = null;
      userPhone = null;
      userPhoto = null;
    });
  }


}
