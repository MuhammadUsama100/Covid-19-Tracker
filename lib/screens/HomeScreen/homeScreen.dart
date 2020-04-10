import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coronavirus/Utils/coronaData/coronaService.dart';
import 'package:coronavirus/Utils/localStorage.dart';
import 'package:coronavirus/constants/constantcolor.dart';
import 'package:coronavirus/screens/Drawer/drawer.dart';
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
    submit = Timer.periodic(Duration(seconds: 50), (Timer t) async {
      DocumentReference ref =
          _db.collection("user").document(Storage.getValue("UserID"));

      ref.updateData({"data": Storage.getlocal("Local")});
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
          DateTime.now().second.toString());
      print(str);
      Storage.setlocal("Local", str);
      str.forEach((f) => print(f));
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
                ListTileCard(
                  cases: this.coronaData[7].cases,
                  country: this.coronaData[7].country,
                  logo: Icon(Icons.flag),
                ),
                ListTileCard(
                  cases: this.pakistan.cases,
                  country: this.pakistan.country,
                  logo: Container(
                    child: Flags.getFullFlag('PK', 100, null),
                    width: 20,
                    height: 20,
                  ),
                ),
                ListTileCard(
                  cases: this.coronaData[8].cases,
                  country: this.coronaData[8].country,
                  logo: Container(
                    child: Flags.getFullFlag('US', 100, null),
                    width: 20,
                    height: 20,
                  ),
                ),
                ListTileCard(
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
  var logo;
  ListTileCard({Key key, this.country, this.cases, this.logo})
      : super(key: key);

  @override
  _ListTileCardState createState() => _ListTileCardState();
}

class _ListTileCardState extends State<ListTileCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: widget.logo,
        title: Text(widget.country),
        trailing: Text(widget.cases.toString()),
      ),
    );
  }
}
