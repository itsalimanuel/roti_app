import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:roti_app/UserScreen/cart.dart';

class ItemDetails extends StatefulWidget {
  String itemName;
  String itemImage;
  String itemSubName;
  double itemPrice;
  double itemRating;

  ItemDetails(
      {this.itemName,
        this.itemImage,
        this.itemRating,
        this.itemPrice,
        this.itemSubName});



  @override
  _ItemDetailsState createState() => _ItemDetailsState();
}


class _ItemDetailsState extends State<ItemDetails> {



  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: new AppBar(
        iconTheme: new IconThemeData(color: Colors.white),
        title: new Text("Item Detail"),
        elevation: 0.0,
        centerTitle: false,
      ),
      bottomNavigationBar: new BottomAppBar(
        color: Colors.white,
        shape: new CircularNotchedRectangle(),
        notchMargin: 5.0,
        child: new Container(

          height: 50.0,
          decoration: new BoxDecoration(color: Colors.white),

        ),
      ),
      floatingActionButton: new Stack(
        alignment: Alignment.topLeft,
        children: <Widget>[
          new FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () {
              Navigator.of(context).push(new CupertinoPageRoute(
                  builder: (BuildContext context) => new CartPage()));
            },
            child: new Icon(Icons.shopping_cart,color: Colors.green,size: 40.0,),
          ),

        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: Colors.white,
      body: new Stack(

        alignment: Alignment.topCenter,
        children: <Widget>[
          new SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            child: new Column(
              children: <Widget>[
                new Icon(Icons.spellcheck,color: Colors.redAccent,size: 100.0,),
                new SizedBox(height: 50.0,),


                new Card(
                  color: Colors.greenAccent,
                  child: new Container(
                    width: screenSize.width,
                    margin: new EdgeInsets.only(left: 20.0, right: 20.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new SizedBox(
                          height: 10.0,
                        ),
                        new Text(
                          widget.itemName,
                          style: new TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w700),
                        ),
                        new SizedBox(
                          height: 10.0,
                        ),
                        new Text(
                          "Item Sub name",
                          style: new TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.w400),
                        ),
                        new SizedBox(
                          height: 10.0,
                        ),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                new Icon(
                                  Icons.star,
                                  color: Colors.blue,
                                  size: 20.0,
                                ),
                                new SizedBox(
                                  width: 5.0,
                                ),
                                new Text(
                                  "${widget.itemRating}",
                                  style: new TextStyle(color: Colors.black),
                                )
                              ],
                            ),
                            new Text(
                              "N${widget.itemPrice}",
                              style: new TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.red[500],
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),


                      ],
                    ),

                  ),

                ),

              ],
            ),

          ),
        ],

      ),
    );
  }
}
