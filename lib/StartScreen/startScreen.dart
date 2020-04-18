import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coronavirus/Utils/authService.dart';
import 'package:coronavirus/Utils/localStorage.dart';
import 'package:coronavirus/screens/HomeScreen/homeScreen.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final Firestore _db = Firestore();

  bool _isSignedIn = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeApp().then((val) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  initializeApp() async {
    await Storage.initialize();

    authService.googleSignIn();
    DocumentReference ref =
        _db.collection("user").document(Storage.getValue("UserID"));
    var data = await ref.get();
    List<String> list = [];
    for (int i = 0; i < data["data"].length; i++) {
      list.add(data["data"][i].toString());
    }
    Storage.setlocal("Local", list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
