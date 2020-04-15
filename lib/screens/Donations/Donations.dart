import 'package:coronavirus/Utils/localStorage.dart';
import 'package:flutter/material.dart';
import 'package:coronavirus/constants/constantcolor.dart';

class DonationsScreen extends StatefulWidget {
  @override
  _DonationsScreenState createState() => _DonationsScreenState();
}

class _DonationsScreenState extends State<DonationsScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Stack(children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: theamColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(120),
                      bottomRight: Radius.circular(120),
                    ),
                    gradient: LinearGradient(
                        begin: Alignment.bottomRight, end: Alignment.topRight,
                        //stops: widget.stops,
                        colors: [drawerGradient, drawerGradient2])),
                width: 600,
                height: 350,
                // color: theamColor,
                child: null,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 200.0),
                child: Center(
                  child: Container(
                    child: CircleAvatar(
                      radius: 145.0,
                      backgroundImage: NetworkImage(Storage.getValue("Image")),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 50,
                      top: 100.0,
                    ),
                    child: Text("Covid -19 Donations ",
                        style: TextStyle(color: Colors.white, fontSize: 24)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 50,
                    ),
                    child: Text("Total Donations",
                        style: TextStyle(color: Colors.white, fontSize: 14)),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      width: 50,
                      child: Icon(
                        Icons.arrow_back,
                        size: 30,
                        color: Colors.white,
                      )),
                ),
              )
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 50.0, left: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("100 RS",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: theamColor)),
                      Text("Your Total Donations",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0, left: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("100 RS",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: theamColor)),
                      Text("This Month Donations",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey))
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Container(
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomRight, end: Alignment.topRight,
                        //stops: widget.stops,
                        colors: [theamColor, drawerGradient, drawerGradient2])),
                child: RaisedButton(
                  color: theamColor,
                  colorBrightness: Brightness.light,
                  onPressed: () {},
                  child: Text("Donate And Save Lifes"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
