import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coronavirus/Utils/localStorage.dart';
import 'package:coronavirus/constants/constantcolor.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  UserProfile({Key key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final Firestore _db = Firestore();
  DocumentReference ref;
  String check;

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
                                Text("Status : ",
                                    style: TextStyle(color: Colors.white)),
                                Text("${check} Corona  ",
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
                            Row(
                              children: <Widget>[
                                Text("Threat Level : ",
                                    style: TextStyle(color: Colors.white)),
                                Text("ZERO",
                                    style: TextStyle(color: Colors.white)),
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
                  padding:
                      const EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
                  child: Builder(
                    builder: (context) => InkWell(
                      onTap: () async {
                        if (data["status"] == "No" && check == "No") {
                          check = "Yes";
                          setState(() {});

                          await ref.updateData({"status": "Yes"}).then((val) {
                            setState(() {});
                          });
                        } else {
                          check = "No";
                          setState(() {});
                          await ref.updateData({"status": "No"}).then((val) {
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
                          title: Text("Test Covid-19 ",
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
              ],
            ),
    );
  }
}
