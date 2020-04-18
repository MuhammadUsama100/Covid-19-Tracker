import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coronavirus/Utils/localStorage.dart';
import 'package:coronavirus/constants/constantcolor.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class UserProfile extends StatefulWidget {
  UserProfile({Key key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final Firestore _db = Firestore();
  DocumentReference ref;
  String check;
  var usman;
  var data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData().then((val) {
      setState(() {});
    });
  }

  fetchData() async {
    print("usama");
    ref = _db.collection("user").document(Storage.getValue("UserID"));
    var refx = _db.collection("user").document("Uy9JSVGUjAYzQ0zm7WqI5OMi8LH3");
    this.usman = await refx.get();
    this.data = await ref.get();
    check = data["status"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: this.data == null
          ? AppBar(
              backgroundColor: theamColor,
            )
          : PreferredSize(
              preferredSize: Size.fromHeight(170.0),
              child: AppBar(
                backgroundColor: theamColor,
                flexibleSpace: Container(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Center(
                        child: Container(
                            child: CircleAvatar(
                          radius: 40.0,
                          backgroundImage:
                              NetworkImage(Storage.getValue("Image")),
                          backgroundColor: Colors.transparent,
                        )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 20),
                      child: Center(
                        child: Container(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(Storage.getValue("UserName"),
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white)),
                            Text(Storage.getValue("UserEmail"),
                                style: TextStyle(color: Colors.white)),
                            Row(
                              children: <Widget>[
                                Text("Coronavirus Infection : ",
                                    style: TextStyle(color: Colors.white)),
                                Text("${check}",
                                    style: TextStyle(color: Colors.white)),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Container(
                                    width: 10,
                                    height: 10,
                                    decoration: new BoxDecoration(
                                      color: check == "Yes"
                                          ? Colors.black
                                          : Colors.lightGreen,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        )),
                      ),
                    )
                  ],
                )),
              ),
            ),
      body: this.data == null
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                  child: Card(
                    elevation: 2,
                    child: Container(
                      height: 85,
                      child: Center(
                        child: ListTile(
                          trailing: Container(
                            width: 100,
                            height: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                CircularProgressIndicator(
                                  backgroundColor: theamColor,
                                  strokeWidth: 3,
                                  value: this.usman["check"] == true ? 0.9 : 0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: this.usman["check"] == true
                                      ? Text("90%")
                                      : Text("0%"),
                                ),
                              ],
                            ),
                          ),
                          leading: Icon(Icons.score),
                          title: Text("Risk Factor ",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                  child: Builder(
                    builder: (context) => InkWell(
                      onTap: () async {
                        if (data["status"] == "No" && check == "No") {
                          check = "Yes";
                          setState(() {});

                          await ref.updateData({"status": "Yes"}).then((val) {
                            setState(() {});
                          });
                          await ref.updateData({"check": true}).then((val) {
                            setState(() {});
                          });
                        } else {
                          check = "No";
                          setState(() {});
                          await ref.updateData({"status": "No"}).then((val) {
                            setState(() {});
                          });
                          await ref.updateData({"check": false}).then((val) {
                            setState(() {});
                          });
                        }

                        final snackBar = SnackBar(
                          content: Text('Status Changed'),
                        );
                        setState(() {});
                        Scaffold.of(context).showSnackBar(snackBar);
                      },
                      child: Card(
                        elevation: 2,
                        child: Container(
                          height: 85,
                          child: Center(
                            child: ListTile(
                              leading: Icon(Icons.insert_chart),
                              title: Text("Change Status",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                  child: Card(
                    elevation: 2,
                    child: Container(
                      height: 85,
                      child: Center(
                        child: ListTile(
                          leading: Icon(Icons.score),
                          title: Text("Upload Report",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                  child: Card(
                    elevation: 2,
                    child: Container(
                      height: 85,
                      child: Center(
                        child: ListTile(
                          leading: Icon(Icons.score),
                          title: Text("Government  Certificate",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                  child: Card(
                    elevation: 2,
                    child: Container(
                      height: 85,
                      child: Center(
                        child: ListTile(
                          leading: Icon(Icons.score),
                          title: Text("Instructions",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          subtitle: Text(
                              "What should you do with each threat level and under CoronaVirus ",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                  child: Card(
                    elevation: 2,
                    child: Container(
                      height: 85,
                      child: Center(
                        child: ListTile(
                          leading: Icon(Icons.score),
                          title: Text("Test COVID-19 ",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          subtitle: Text(
                              "Test based on symptoms and historical data analysis",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
