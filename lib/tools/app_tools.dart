import 'package:flutter/material.dart';
import 'package:roti_app/tools/progressdialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget appTextField(
    {IconData textIcon,
    String textHint,
    bool isPassword,
    double sidePadding,
    TextInputType textType,
    TextEditingController controller}) {
  sidePadding == null ? sidePadding = 0.0 : sidePadding;
  textHint == null ? textHint = "" : textHint;
  textType == null ? textType == TextInputType.text : textType;

  return Padding(
    padding: new EdgeInsets.only(left: sidePadding, right: sidePadding),
    child: new Container(
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.all(new Radius.circular(35.0)),
      ),
      child: new TextField(
        controller: controller,
        obscureText: isPassword == null ? false : isPassword,
        keyboardType: textType,
        decoration: new InputDecoration(
          border: InputBorder.none,
          hintText: textHint,
          prefixIcon: textIcon == null ? new Container() : new Icon(textIcon),
        ),
      ),
    ),
  );
}

Widget appButton(
    {String btnTxt,
    double btnPadding,
    Color btnColor,
    VoidCallback onBtnClick}) {
  btnTxt == null ? btnTxt == "App Button" : btnTxt;
  btnPadding == null ? btnPadding == 0.0 : btnPadding;
  btnColor == null ? btnColor = Colors.black : btnColor;

  return Padding(
    padding: new EdgeInsets.all(btnPadding),
    child: new RaisedButton(
      color: Colors.white,
      textColor: Colors.green,
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.all(new Radius.circular(15.0))),
      onPressed: onBtnClick,
      child: Container(
        height: 60.0,
        child: new Center(
          child: new Text(btnTxt,
              style: new TextStyle(color: btnColor, fontSize: 15.0)),
        ),
      ),
    ),
  );
}

Widget productTextField(
    {String titleText,
    String textHint,
    double height,
    TextInputType textType,
    TextEditingController controller}) {
  titleText == null ? titleText = "Text Title" : titleText;
  textHint == null ? textHint = "Enter Hint" : textHint;
  height == null ? height = 50.0 : height;

  return Column(
    children: <Widget>[
      new Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Text(
          titleText,
          style: new TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      new Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: new Container(
            height: height,
            decoration: new BoxDecoration(
                border: new Border.all(color: Colors.black12),
                borderRadius: new BorderRadius.all(new Radius.circular(4.0))),
            child: new Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: new TextField(
                controller: controller,
                keyboardType: textType == null ? TextInputType.text : textType,
                decoration: new InputDecoration(
                    border: InputBorder.none, hintText: textHint),
              ),
            ),
          ))
    ],
  );
}

Widget productDropDown({String titleText,
    String selectedItem,
    List<DropdownMenuItem<String>> dropDownItems,
    ValueChanged changedDropDownItem}) {
  titleText == null ? titleText = "Text Title" : titleText;

  return Column(
    children: <Widget>[
      new Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Text(
          titleText,
          style: new TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: new DropdownButtonHideUnderline(
            child: new DropdownButton(
          items: dropDownItems,
          onChanged: changedDropDownItem,
          value: selectedItem,
        )),
      ),
    ],
  );
}

Widget OrderPorduct(String textTitle,
    {String phoneNumber,
    String selectItem,
    List<DropdownMenuItem<String>> dropDownItems,
    ValueChanged changedItem}) {
  textTitle == null ? textTitle = "Enter Title" : textTitle;
  return Column(
    children: <Widget>[
      new Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Text(
          textTitle,
          style: new TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: new DropdownButtonHideUnderline(
            child: new DropdownButton(
              value: selectItem,
          items: dropDownItems,
          onChanged: changedItem,
        )),
      )
    ],
  );
}



List<DropdownMenuItem<String>> buildAndGetDrop(List size){
  List<DropdownMenuItem<String>> items = new List();
  for (String size in size){
    items.add(new DropdownMenuItem(value: size  ,child: new  Text(size)));
  }
  return items;
}






showSnackbar(String message, final scaffoldKey) {
  scaffoldKey.currentState.showSnackBar(new SnackBar(
      backgroundColor: Colors.green[600],
      content: new Text(
        message,
        style: TextStyle(color: Colors.white),
      )));
}

displayProgressDialog(BuildContext context) {
  Navigator.of(context).push(new PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, _, __) {
        return new ProgressDialog();
      }));
}

closeProgressDialog(BuildContext context) {
  Navigator.of(context).pop();
}

writeDataLocally({String key, String value}) async {
  Future<SharedPreferences> saveLocal = SharedPreferences.getInstance();
  final SharedPreferences localData = await saveLocal;
  localData.setString(key, value);
}

writeBoolDataLocally({String key, bool value}) async {
  Future<SharedPreferences> saveLocal = SharedPreferences.getInstance();
  final SharedPreferences localData = await saveLocal;
  localData.setBool(key, value);
}

getDataLocally({String key}) async {
  Future<SharedPreferences> saveLocal = SharedPreferences.getInstance();
  final SharedPreferences localData = await saveLocal;
  return localData.get(key);
}

getStringDataLocally({String key}) async {
  Future<SharedPreferences> saveLocal = SharedPreferences.getInstance();
  final SharedPreferences localData = await saveLocal;
  return localData.getString(key);
}

getBoolDataLocally({String key}) async {
  Future<SharedPreferences> saveLocal = SharedPreferences.getInstance();
  final SharedPreferences localData = await saveLocal;
  return localData.getBool(key) == null ? false : localData.getBool(key);
}

clearDataLocally() async {
  Future<SharedPreferences> saveLocal = SharedPreferences.getInstance();
  final SharedPreferences localData = await saveLocal;
  localData.clear();
}
