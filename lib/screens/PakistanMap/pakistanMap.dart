import 'package:coronavirus/Utils/htmlparser.dart';
import "package:coronavirus/constants/constantcolor.dart";
import 'package:coronavirus/locals/locals.dart';
import 'package:coronavirus/screens/Donations/Donations.dart';
import 'package:coronavirus/screens/Help/helpscreen.dart';
import 'package:flutter/material.dart';

class PakistanMap extends StatefulWidget {
  PakistanMap({Key key}) : super(key: key);

  @override
  _PakistanMapState createState() => _PakistanMapState();
}

class _PakistanMapState extends State<PakistanMap> {
  int index = 0;
  String deaths = " ";
  String data = " ";
  String name = " ";
  String imageURL = null;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData().then((val) {
      // setstate() {}
    });
  }

  fetchData() async {
    await fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            title: Text(AppLocations.of(context).donations),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help),
            title: Text(AppLocations.of(context).help),
          ),
        ],
        currentIndex: index,
        selectedItemColor: theamColor,
        onTap: (int index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DonationsScreen()),
            );
          } else {
            showAlertHelp(context, AppLocations.of(context).howitworks);
          }
        },
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
                    Text(AppLocations.of(context).pakistanCases,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    Text("active Cases : 6,272",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        )),
                    Text("Death : 176",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        )),
                    Text("Recovered :  1,970",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        )),
                    Text("Total Cases : 8,418",
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
                      top: 20.0,
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
                        this.name == " "
                            ? Container()
                            : Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  "${name}",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                        this.data == " "
                            ? Container()
                            : Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  "Cases : ${data}",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                        this.deaths == " "
                            ? Container()
                            : Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  "Death : ${deaths}",
                                  style: TextStyle(color: Colors.grey),
                                ),
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
                              name = "Sindh";
                              this.data = "2,537";
                              this.deaths = "56";

                              this.imageURL = "assets/sindh.png";
                              setState(() {});
                            } else if ((obj.localPosition.dx - 150).abs() <
                                    19.0 &&
                                (obj.localPosition.dy - 124).abs() < 30.0) {
                              this.data = "3,721";
                              this.deaths = "42";
                              name = ("Punjab");
                              this.imageURL = "assets/panjab.png";
                              setState(() {});
                            } else if ((obj.localPosition.dx - 58).abs() <
                                    30.0 &&
                                (obj.localPosition.dy - 161).abs() < 19.0) {
                              this.data = "432";
                              this.deaths = "5";

                              name = ("Balochistan");
                              this.imageURL = "assets/balochistan.png";
                              setState(() {});
                            } else if ((obj.localPosition.dx - 152).abs() <
                                    19.0 &&
                                (obj.localPosition.dy - 64).abs() < 19.0) {
                              name = ("KPK");
                              this.data = "1,235";
                              this.deaths = "67";
                              this.imageURL = "assets/KPK.png";
                              setState(() {});
                            } else if ((obj.localPosition.dx - 177).abs() <
                                    15.0 &&
                                (obj.localPosition.dy - 63).abs() < 9.0) {
                              name = ("AJK");
                              this.data = "49";
                              this.deaths = "0";
                              this.imageURL = "assets/kashmir.png";
                              setState(() {});
                            } else if ((obj.localPosition.dx - 187).abs() <
                                    19.0 &&
                                (obj.localPosition.dy - 36).abs() < 19.0) {
                              name = ("Gilgit");
                              this.deaths = "3";
                              this.imageURL = "assets/gilgit.png";
                              this.data = "263";
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
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "click the region to see more info: ",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
