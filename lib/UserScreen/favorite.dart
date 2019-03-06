import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:roti_app/UserScreen/cart.dart';
import 'package:roti_app/main.dart';
import 'package:roti_app/tools/FbConn.dart';
import 'package:roti_app/tools/app_data.dart';

class RotiFavorite extends StatefulWidget {
  _RotiFavoriteState createState() => _RotiFavoriteState();
}

class _RotiFavoriteState extends State<RotiFavorite> {
  static DatabaseReference dbRef = FirebaseDatabase.instance.reference();
  static final favoriteRef =
  dbRef.child(AppData.favoriteDB).child(AppData.currentUserID);
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  FbConn fbConn;
  BuildContext context;
  var refreshMenKey = new GlobalKey<RefreshIndicatorState>();
  StreamSubscription<Event> _favoriteSubscription;
  StreamSubscription<Event> _cartSubscription;
  int cartCount;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {});
    _favoriteProducts();
    print(AppData.currentUserID);
    _getCartCount();
  }

  Future _getCartCount() async {
    final cartRef = FirebaseDatabase.instance
        .reference()
        .child(AppData.cartDB)
        .child(AppData.currentUserID);
    _cartSubscription = await cartRef.once().then((snapshot) {
      if (snapshot.value == null) {
        cartCount = 0;
        setState(() {});
        return;
      }

      Map valFav = snapshot.value;
      FbConn fbConn = new FbConn(valFav);
      cartCount = fbConn.getDataSize();
      setState(() {});
    });

    _cartSubscription = cartRef.onValue.listen((event) {
      if (event.snapshot.value == null) {
        cartCount = 0;
        setState(() {});
        return;
      }
      Map valFav = event.snapshot.value;
      FbConn fbConn = new FbConn(valFav);
      cartCount = fbConn.getDataSize();
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _favoriteSubscription.cancel();
  }

  void showInSnackBar(String value) {
    scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  Future _favoriteProducts() async {
    favoriteRef.once().then((snapshot) {
      if (snapshot.value == null) {
        return;
      }
      Map val = snapshot.value;
      fbConn = new FbConn(val);
      setState(() {});
    }).catchError((e) {});
    _favoriteSubscription = favoriteRef.onValue.listen((event) {
      if (event.snapshot.value == null) {
        fbConn = null;
        setState(() {});
        return;
      }
      fbConn = null;
      setState(() {});
      Map val = event.snapshot.value;
      fbConn = new FbConn(val);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
        key: scaffoldKey,
        appBar: new AppBar(
          title: new GestureDetector(
            onLongPress: () {},
            child: new Text(
              "favorites",
              style: new TextStyle(color: Colors.white),
            ),
          ),
          centerTitle: true,
          actions: <Widget>[
            new Stack(
              children: <Widget>[
                new IconButton(
                    icon: new Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(new CupertinoPageRoute(
                          builder: (BuildContext context) => CartPage()));
                    }),
                new Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: new CircleAvatar(
                    radius: 8.0,
                    backgroundColor: Colors.red[900],
                    child: new Text(
                      cartCount.toString(),
                      style: new TextStyle(color: Colors.white, fontSize: 9.0),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
        body: fbConn == null
            ? new Container(
          constraints: const BoxConstraints(maxHeight: 500.0),
          child: new Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(
                  margin: new EdgeInsets.only(top: 00.0, bottom: 0.0),
                  height: 150.0,
                  width: 150.0,
                  child: new Image.asset(''),
                ),
                new Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: new Text(
                    "You have nothing in your favorites...",
                    style: new TextStyle(
                        fontSize: 18.0, color: Colors.black),
                  ),
                )
              ],
            ),
          ),
        )
            : new RefreshIndicator(
          key: refreshMenKey,
          onRefresh: refreshMe,
          child: new CustomScrollView(
            slivers: <Widget>[
              new SliverGridProductList(
                fbConn: fbConn,
              )
            ],
          ),
        ));
  }

  Future<Null> refreshMe() async {
    refreshMenKey.currentState.show();
    fbConn = null;
    setState(() {});
    favoriteRef.once().then((snapshot) {
      if (snapshot.value == null) {
        showInSnackBar("No Data Available!!!");
        return;
      }
      Map val = snapshot.value;
      fbConn = new FbConn(val);
      setState(() {});
    }).catchError((e) {
      showInSnackBar("Error Occured: $e");
    });
    return null;
  }
}

class SliverGridProductList extends StatefulWidget {
  final FbConn fbConn;

  SliverGridProductList({this.fbConn});

  @override
  _SliverGridProductListState createState() => _SliverGridProductListState();
}

class _SliverGridProductListState extends State<SliverGridProductList> {
  BuildContext context;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void showInSnackBar(String value) {
    Scaffold.of(context).showSnackBar(new SnackBar(content: new Text(value)));
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return new RefreshIndicator(
        child: new SliverGrid(
            delegate: new SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  final buttons = new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new Container(
                        height: 20.0,
                        decoration: new BoxDecoration(
                            borderRadius:
                            new BorderRadius.all(new Radius.circular(5.0))),
                        child: new Center(
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              new Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: new Icon(
                                  Icons.delete_forever,
                                  size: 15.0,
                                  color: MyApp.appColors[600],
                                ),
                              ),
                              new GestureDetector(
                                onTap: () {
                                  widget.fbConn.removeFavorite1(index);
                                  setState(() {
                                    showInSnackBar(widget.fbConn
                                        .getProductNameAsList()[index] +
                                        "has been removed from your favorite");
                                  });
                                },
                                child: new Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: new Text(
                                    "Remove",
                                    style: new TextStyle(
                                        color: MyApp.appColors[600],
                                        fontSize: 10.0),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      new Container(
                        height: 20.0,
                        width: 1.0,
                        color: Colors.black12,
                        margin: const EdgeInsets.only(left: 2.0, right: 2.0),
                      ),
                      new Container(
                        height: 20.0,
                        decoration: new BoxDecoration(
                          borderRadius: new BorderRadius.all(
                            new Radius.circular(5.0),
                          ),
                        ),
                        child: new Center(
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              new Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: new Icon(
                                  Icons.add_shopping_cart,
                                  size: 15.0,
                                  color: MyApp.appColors[600],
                                ),
                              ),
                              new GestureDetector(
                                onTap: () {
                                  widget.fbConn.addToCart(index, 1);
                                  setState(() {
                                    showInSnackBar(
                                        widget.fbConn.getProductName() +
                                            " has been added to your cart");
                                  });
                                },
                                child: new Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: new Text("SHOP",
                                    style: new TextStyle(
                                        color: MyApp.appColors[600],
                                        fontSize: 10.0
                                    ),),),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                  return new GestureDetector(
                    onLongPress: () {},
                    child: new Card(
                      child: new GridTile(child: new Column(
                        children: <Widget>[
                          new Padding(padding: const EdgeInsets.all(5.0),
                            child: new Image.network(
                              widget.fbConn.getDefaultIMGAsList()[index],
                              height: 100.0,),
                          ),
                          new Align(
                            alignment: Alignment.center,
                            child: new Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: new Text("N" +
                                  widget.fbConn.getProductPriceAsList()[index]),
                            ),
                          ),
                          buttons
                        ],
                      ),
                      ),
                    ),
                  );
                },
              childCount: widget.fbConn.getDataSize() == null ?
                  0 : widget.fbConn.getDataSize(),
            ),
           ),
        onRefresh: (){},
        );
  }
}
