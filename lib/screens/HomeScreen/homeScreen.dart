import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coronavirus/Models/friend.dart';
import 'package:coronavirus/Models/tracker.dart';
import 'package:coronavirus/Utils/coronaData/coronaService.dart';
import 'package:coronavirus/Utils/localStorage.dart';
import 'package:coronavirus/constants/constantcolor.dart';
import 'package:coronavirus/screens/Drawer/drawer.dart';
import 'package:coronavirus/screens/PakistanMap/pakistanMap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flag/flag.dart';

import 'package:coronavirus/Models/coronaData.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Timer timer;
  Timer timeGps;
  Timer submit;
  List friend = [];
  final Firestore _db = Firestore();
  List<CoronaData> coronaData;
  CoronaData pakistan;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (this.coronaData == null) {
      print("object");
      initialize().then((val) {
        setState(() {
          // print(this.coronaData[0]);
        });
      });
      //print(this.coronaData[0]);
    } else
      timer = Timer.periodic(Duration(minutes: 120), (Timer t) async {
        this.coronaData = null;
        initialize();
        setState(() {});
      });
    gpsLocal();
    //18000

    submit = Timer.periodic(Duration(seconds: 18000), (Timer t) async {
      DocumentReference ref =
          _db.collection("user").document(Storage.getValue("UserID"));

      ref.updateData({"data": Storage.getlocal("Local")});
      QuerySnapshot querySnapshot =
          await Firestore.instance.collection("user").getDocuments();
      querySnapshot.documents.forEach((doc) {
        List list = doc["data"];
        List localList = Storage.getlocal("Local");
        list.forEach((val) {
          Track tack = Storage.parse(val.toString());
          localList.forEach((locVal) async {
            print("object");
            Track localtack = Storage.parse(locVal.toString());
            print(localtack.time);
            if ((DateTime.parse(localtack.time).millisecondsSinceEpoch -
                        DateTime.parse(tack.time).millisecondsSinceEpoch)
                    .abs() <
                1000) {
              print("usama1");
              var latlocal = double.parse(localtack.lat);
              assert(latlocal is double);
              var longlocal = double.parse(localtack.lat);
              assert(longlocal is double);
              var lat = double.parse(localtack.lat);
              assert(lat is double);
              var long = double.parse(localtack.lat);
              assert(long is double);
              print(long);

              if ((latlocal - lat).abs() < 3 &&
                  (longlocal - long).abs() < 3 &&
                  doc["email"] != Storage.getValue("UserEmail")) {
                print("usama1");
                print("usama1");

                // add to list  ;

                var friends = await ref.get();
                List list = friends.data["friends"];
                bool alreadyFriend = false;
                print(doc["email"]);
                list.forEach((f) {
                  if (doc["email"].toString() == f.email.toString()) {
                    alreadyFriend = true;
                  }
                });
                if (!alreadyFriend) {
                  list.add({
                    "logo": doc["logo"],
                    "name": doc["name"],
                    "email": doc["email"],
                    "status": doc["status"]
                  });
                  list.forEach((f) {
                    this.friend.add(f);
                  });
                }
              }
              //time compared
              print("part1");
            }
          });
        });
      });
      ref.updateData({"friends": this.friend});
      // Storage.setlocal("Local", []);
    });
  }

  gpsLocal() async {
    timeGps = Timer.periodic(Duration(seconds: 20), (Timer t) async {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      List<String> str = Storage.getlocal("Local");
      str.add(position.latitude.toString() +
          " " +
          position.longitude.toString() +
          " " +
          DateTime.now().toString());
      // print(str);
      Storage.setlocal("Local", str);
      // str.forEach((f) => print(f));
    });
  }

  initialize() async {
    this.coronaData = await fetchCoronaDatas(http.Client());
    coronaData.toList().forEach((val) {
      if (val.country == "Pakistan") {
        this.pakistan = val;
      }
    });
    // print(coronaData[0]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(child: DrawerScreen()),
      appBar: AppBar(
        title: Text(homePage),
        backgroundColor: theamColor,
      ),
      body: this.coronaData == null
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: <Widget>[
                MapCard(),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PakistanMap()),
                    );
                  },
                  child: ListTileCard(
                    val: 1,
                    cases: this.pakistan.cases,
                    country: this.pakistan.country,
                    logo: Container(
                      child: Flags.getFullFlag('PK', 100, null),
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
                ListTileCard(
                  val: 0,
                  cases: this.coronaData[7].cases,
                  country: this.coronaData[7].country,
                  logo: Icon(Icons.flag),
                ),
                ListTileCard(
                  val: 0,
                  cases: this.coronaData[8].cases,
                  country: this.coronaData[8].country,
                  logo: Container(
                    child: Flags.getFullFlag('US', 100, null),
                    width: 20,
                    height: 20,
                  ),
                ),
                ListTileCard(
                  val: 0,
                  cases: this.coronaData[9].cases,
                  country: this.coronaData[9].country,
                  logo: Container(
                    child: Flags.getFullFlag('ES', 100, null),
                    width: 20,
                    height: 20,
                  ),
                ),
              ],
            ),
    );
  }
}

class MapCard extends StatefulWidget {
  MapCard({Key key}) : super(key: key);

  @override
  _MapCardState createState() => _MapCardState();
}

class _MapCardState extends State<MapCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 80.0),
      child: Container(
        height: 300,
        child: Image.network(map, fit: BoxFit.fill),
      ),
    );
  }
}

class ListTileCard extends StatefulWidget {
  var country;
  var cases;
  var val;
  var logo;
  ListTileCard({Key key, this.country, this.cases, this.val, this.logo})
      : super(key: key);

  @override
  _ListTileCardState createState() => _ListTileCardState();
}

class _ListTileCardState extends State<ListTileCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.val == 0 ? Colors.white : drawerGradient,
      elevation: 2,
      child: ListTile(
        leading: widget.logo,
        title: Text(widget.country),
        trailing: Text(widget.cases.toString()),
      ),
    );
  }
}
