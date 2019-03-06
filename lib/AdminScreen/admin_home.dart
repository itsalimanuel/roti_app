import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:roti_app/AdminScreen/find_users.dart';
import 'package:roti_app/AdminScreen/order_history.dart';
import 'package:roti_app/AdminScreen/search_data.dart';
import 'package:roti_app/AdminScreen/user_account.dart';
import 'package:roti_app/AdminScreen/user_message.dart';
import 'package:roti_app/AdminScreen/user_order.dart';

class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  Size screenSize;

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: new AppBar(
        title: new Text("Support Page"),
        centerTitle: true,
        elevation: 0.0,
      ),
      endDrawer: new Container(
        width: screenSize.width - 50,
        color: Colors.white,
        child: Column(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text(""),
              accountEmail: new Text(""),
              currentAccountPicture: new CircleAvatar(
                backgroundColor: Colors.green,
                child: new Icon(Icons.people),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: new Column(
          children: <Widget>[
            new SizedBox(
              height: 10.0,
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(new CupertinoPageRoute(
                        builder: (context) => GirliesOrderSearch()));
                  },
                  child: new CircleAvatar(
                    maxRadius: 80.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Icon(Icons.search),
                        new SizedBox(
                          height: 10.0,
                        ),
                        new Text("Find Order"),
                      ],
                    ),
                  ),
                ),
                new GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(new CupertinoPageRoute(
                        builder: (context) => FindUser()));
                  },
                  child: new CircleAvatar(
                    maxRadius: 80.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Icon(Icons.wifi_tethering),
                        new SizedBox(
                          height: 10.0,
                        ),
                        new Text("Find User"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            new SizedBox(
              height: 10.0,
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(new CupertinoPageRoute(
                        builder: (context) => UserAccount()));
                  },
                  child: new CircleAvatar(
                    maxRadius: 80.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Icon(Icons.person),
                        new SizedBox(
                          height: 10.0,
                        ),
                        new Text("Users Accounts"),
                      ],
                    ),
                  ),
                ),
                new GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(new CupertinoPageRoute(
                        builder: (context) => ChatScreen()));
                  },
                  child: new CircleAvatar(
                    maxRadius: 80.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Icon(Icons.chat),
                        new SizedBox(
                          height: 10.0,
                        ),
                        new Text("User Message"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            new SizedBox(
              height: 10.0,
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(new CupertinoPageRoute(
                        builder: (context) => UserOrder()));
                  },
                  child: new CircleAvatar(
                    maxRadius: 80.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Icon(Icons.notifications_active),
                        new SizedBox(
                          height: 10.0,
                        ),
                        new Text("Users Orders"),
                      ],
                    ),
                  ),
                ),
                new GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(new CupertinoPageRoute(
                        builder: (context) => SearchHistory()));
                  },
                  child: new CircleAvatar(
                    maxRadius: 80.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Icon(Icons.history),
                        new SizedBox(
                          height: 10.0,
                        ),
                        new Text("Order History"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
