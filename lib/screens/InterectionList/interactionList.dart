import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coronavirus/Utils/localStorage.dart';
import 'package:coronavirus/constants/constantcolor.dart';
import 'package:coronavirus/screens/InterectionList/interrectionTile.dart';
import 'package:flutter/material.dart';

class InterctionList extends StatefulWidget {
  @override
  _InterctionListState createState() => _InterctionListState();
}

class _InterctionListState extends State<InterctionList> {
  var data;
  static final _appBar = AppBar(
    backgroundColor: theamColor,
    title: Text(
      'Interaction List',
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  );

  final Firestore _db = Firestore();

  @override
  void initState() {
    super.initState();
    initialize().then((e) {
      setState(() {});
    });
  }

  initialize() async {
    DocumentReference ref =
        _db.collection("user").document(Storage.getValue("UserID"));
    this.data = await ref.get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: this.data == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
              child: Container(
                  child: ListView.builder(
                      itemCount: this.data["friends"].length == 0
                          ? 1
                          : this.data["friends"].length,
                      itemBuilder: (context, index) {
                        return this.data["friends"].length == 0
                            ? Container()
                            : UserTile(
                                name: data["friends"][index]["name"],
                                email: data["friends"][index]["email"],
                                status: data["friends"][index]["status"],
                                logo: data["friends"][index]["logo"]);
                      })),
            ),
    );
  }
}
