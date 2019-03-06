import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:roti_app/tools/app_method.dart';
import 'app_data.dart';
import 'app_tools.dart';
import 'package:flutter/services.dart';
import 'dart:ui';

class FirebaseMethods implements AppMethods {
  Firestore firestore = Firestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Future<String> createUserAccount(
      {String fullname, String phone, String email, String password}) async {
    // TODO: implement createUserAccount
    FirebaseUser user;

    try {
      user = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on PlatformException catch (e) {
      //print(e.message);
      return errorMSG(e.message);
    }

    try {
      if (user != null) {
        await firestore.collection(usersData).document(user.uid).setData({
          userID: user.uid,
          fullName: fullname,
          userEmail: email,
          userPassword: password,
          phoneNumber: phone
        });
        writeDataLocally(key: userID, value: user.uid);
        writeDataLocally(key: fullname, value: fullname);
        writeDataLocally(key: userEmail, value: userEmail);
        writeDataLocally(key: userPassword, value: userPassword);
      }
    } on PlatformException catch (e) {
      print(e.message);
      return errorMSG(e.message);
    }
    return user == null ? errorMSG("error") : successMSG();
  }

  @override
  Future<String> logginUser({String email, String password}) async {
    // TODO: implement logginUser
    FirebaseUser user;
    try {
      user = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (user != null) {
        DocumentSnapshot userInfo = await getUserInfo(user.uid);
        await writeDataLocally(key: userID, value: userInfo[userID]);
        await writeDataLocally(key: fullName, value: userInfo[fullName]);
        await writeDataLocally(key: userEmail, value: userInfo[userEmail]);
        await writeDataLocally(key: phoneNumber, value: userInfo[phoneNumber]);
        await writeDataLocally(key: userPhoto, value: userInfo[userPhoto]);
        await writeBoolDataLocally(key: loggedIn, value: true);

        print(userInfo[userEmail]);
      }
    } on PlatformException catch (e) {
      print(e.message);
      return errorMSG(e.message);
    }

    return user == null ? errorMSG("error") : successMSG();
  }

  Future<bool> complete() async {
    return true;
  }

  Future<bool> notComplete() async {
    return false;
  }

  Future<String> successMSG() async {
    return successful;
  }

  Future<String> errorMSG(String e) async {
    return e;
  }

  @override
  Future<bool> logOutUser() async {
    // TODO: implement logOutUser
    await auth.signOut();
    await clearDataLocally();

    return complete();
  }

  @override
  Future<DocumentSnapshot> getUserInfo(String userid) async {
    // TODO: implement getUserInfo
    return await firestore.collection(usersData).document(userid).get();
  }
}
