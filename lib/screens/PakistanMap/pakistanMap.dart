import "package:coronavirus/constants/constantcolor.dart";
import 'package:flutter/material.dart';

class PakistanMap extends StatefulWidget {
  PakistanMap({Key key}) : super(key: key);

  @override
  _PakistanMapState createState() => _PakistanMapState();
}

class _PakistanMapState extends State<PakistanMap> {
  int index = 0;
  String imageURL = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            title: Text('View Donations'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help),
            title: Text('Help'),
          ),
        ],
        currentIndex: index,
        selectedItemColor: theamColor,
        onTap: (int index) {},
      ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(170.0),
        child: AppBar(
          backgroundColor: theamColor,
          flexibleSpace: Container(
              child: Padding(
            padding: const EdgeInsets.only(top: 40.0, right: 30),
            child: Center(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Pakistan Cases",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    Text("active Cases",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        )),
                    Text("Death",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        )),
                    Text("Recovered",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        )),
                    Text("Total Cases",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        )),
                  ],
                ),
              ),
            ),
          )),
        ),
      ),
      body: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 30.0,
                    ),
                    child: Container(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Current Status",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "click the region to ",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 8.0,
                          ),
                          child: Text("see more info:",
                              style: TextStyle(color: Colors.grey)),
                        ),
                      ],
                    )),
                  ),
                  Container(
                      child: this.imageURL == null
                          ? Container()
                          : Container(
                              width: 100,
                              height: 200,
                              child: Image.asset(this.imageURL)))
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Builder(
                  builder: (context) => Container(
                      width: 230,
                      height: 230,
                      child: GestureDetector(
                          onTapUp: (var obj) {
                            print(obj.localPosition.dx);
                            print(obj.localPosition.dy);
                            if ((obj.localPosition.dx - 110).abs() < 19.0 &&
                                (obj.localPosition.dy - 185).abs() < 19.0) {
                              print("sindh");

                              this.imageURL = "assets/sindh.png";
                              setState(() {});
                            } else if ((obj.localPosition.dx - 150).abs() <
                                    19.0 &&
                                (obj.localPosition.dy - 124).abs() < 30.0) {
                              print("panjab");
                              this.imageURL = "assets/panjab.png";
                              setState(() {});
                            } else if ((obj.localPosition.dx - 58).abs() <
                                    30.0 &&
                                (obj.localPosition.dy - 161).abs() < 19.0) {
                              print("balochistan");
                              this.imageURL = "assets/balochistan.png";
                              setState(() {});
                            } else if ((obj.localPosition.dx - 152).abs() <
                                    19.0 &&
                                (obj.localPosition.dy - 64).abs() < 19.0) {
                              print("KPK");
                              this.imageURL = "assets/KPK.png";
                              setState(() {});
                            } else if ((obj.localPosition.dx - 177).abs() <
                                    9.0 &&
                                (obj.localPosition.dy - 63).abs() < 9.0) {
                              print("Azad Kashmir ");
                              this.imageURL = "assets/kashmir.png";
                              setState(() {});
                            } else if ((obj.localPosition.dx - 187).abs() <
                                    19.0 &&
                                (obj.localPosition.dy - 36).abs() < 19.0) {
                              print("Gilgit");
                              this.imageURL = "assets/gilgit.png";
                              setState(() {});
                            }
                          },
                          onTap: () => print('tap'),
                          behavior: HitTestBehavior.opaque,
                          child: Image.asset(
                            "assets/pakistan.png",
                            width: 260,
                          ))),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Text(
                  "More Information ->",
                  style: TextStyle(color: Colors.grey),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
