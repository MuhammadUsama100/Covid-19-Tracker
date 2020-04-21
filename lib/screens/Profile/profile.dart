import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coronavirus/Utils/localStorage.dart';
import 'package:coronavirus/constants/constantcolor.dart';
import 'package:coronavirus/locals/locals.dart';
import 'package:coronavirus/screens/QrCodeScanner/qrScanner.dart';
import 'package:coronavirus/screens/Qrcodes/qrcode.dart';
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
                  child: Builder(
                    builder: (context) => InkWell(
                        onTap: () {
                          showAlertDialog(
                              context,
                              (data["thread"]["percent"] / 100).toString(),
                              "Thread Level");
                        },
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      CircularProgressIndicator(
                                        backgroundColor: theamColor,
                                        strokeWidth: 3,
                                        value: data["thread"]["percent"] / 100,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(data["thread"]["percent"]
                                            .toString()),
                                      ),
                                    ],
                                  ),
                                ),
                                leading: Icon(Icons.score),
                                title: Text(AppLocations.of(context).riskFector,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                        )),
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
                          await ref.updateData({
                            "thread": {
                              "percent": 100,
                              "threadDate": DateTime.now().day
                            }
                          }).then((val) {
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
                          content: Text(AppLocations.of(context).changeStatus),
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
                              title: Text(AppLocations.of(context).changeStatus,
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
                  child: Builder(
                    builder: (context) => InkWell(
                      onTap: () async {
                        var status = await scan();
                        if (status == "Yes" || status == "No")
                          await ref.updateData({"status": status}).then((val) {
                            setState(() {});
                          });
                        else {
                          final snackBar = SnackBar(
                              content: Text(AppLocations.of(context).snackbar));

                          Scaffold.of(context).showSnackBar(snackBar);
                        }
                      },
                      child: Card(
                          elevation: 2,
                          child: Container(
                            height: 85,
                            child: Center(
                              child: ListTile(
                                leading: Icon(Icons.score),
                                subtitle: Text("Scan QrCode on COVID-19 Report",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold)),
                                title: Text(AppLocations.of(context).scanReport,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                  child: Builder(
                    builder: (context) => InkWell(
                      onTap: () {
                        showAlertDialog(context, Storage.getValue("UserID"),
                            AppLocations.of(context).scanCodeText);
                      },
                      child: Card(
                          elevation: 2,
                          child: Container(
                            height: 85,
                            child: Center(
                              child: ListTile(
                                leading: Icon(Icons.score),
                                title: Text(
                                    AppLocations.of(context).qrcodeStatus,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                subtitle: Text(
                                    "Generate QR code to update status",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          )),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
