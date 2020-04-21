import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coronavirus/Utils/localStorage.dart';
import 'package:coronavirus/constants/constantcolor.dart';
import 'package:coronavirus/locals/locals.dart';
import 'package:coronavirus/screens/InterectionList/interrectionTile.dart';
import 'package:flutter/material.dart';

class InterctionList extends StatefulWidget {
  @override
  _InterctionListState createState() => _InterctionListState();
}

class _InterctionListState extends State<InterctionList> {
  var data;

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
      appBar: AppBar(
        backgroundColor: theamColor,
        title: Text(
          AppLocations.of(context).interaction,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
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
                            ? Container(
                                child: Center(
                                    child: Center(
                                  child: Text(
                                      "You are Secure had not interacted with any one",
                                      style: TextStyle(color: Colors.grey)),
                                )),
                              )
                            : UserTile(
                                name: this.data["friends"][index]["email"],
                                email: this.data["friends"][index]["id"],
                                status: this.data["friends"][index]["status"],
                                logo: "k");
                      })),
            ),
    );
  }
}
