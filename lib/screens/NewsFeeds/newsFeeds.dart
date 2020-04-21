import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coronavirus/Utils/localStorage.dart';
import 'package:coronavirus/constants/constantcolor.dart';
import 'package:coronavirus/locals/locals.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class NewesFeeds extends StatefulWidget {
  NewesFeeds({Key key}) : super(key: key);

  @override
  _NewesFeedsState createState() => _NewesFeedsState();
}

class _NewesFeedsState extends State<NewesFeeds> {
  var data;
  List<String> value = [];
  final Firestore _db = Firestore();

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
    DocumentReference ref =
        _db.collection("news").document("Y2nPEPxk8MgHrCOzrBY5");

    this.data = await ref.get();
    this.data["news"].forEach((val) {
      String str = "";
      for (int i = 0; i < 48 * 2; i++) {
        str = str + val["dis"][i];
      }
      str = str + "...";
      this.value.add(str.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocations.of(context).newsFeed),
          backgroundColor: theamColor,
        ),
        body: this.data == null
            ? Center(child: Container(child: CircularProgressIndicator()))
            : Container(
                child: ListView.builder(
                    itemCount: this.data["news"].length,
                    itemBuilder: (context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 200,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailScreen(
                                          dis: this.data["news"][index]["dis"],
                                          image: this.data["news"][index]
                                              ["image"],
                                          link: this.data["news"][index]["url"],
                                          title: this.data["news"][index]
                                              ["title"],
                                        )),
                              );
                            },
                            child: Card(
                                elevation: 5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        child: Text(
                                            this.data["news"][index]["title"],
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                    Container(
                                      child: Image.network(this
                                          .data
                                          .data["news"][index]["image"]),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Container(
                                            child: Text(this.value[index]),
                                          ),
                                        )),

                                    // Padding(
                                    //   padding: const EdgeInsets.all(8.0),
                                    //   child: InkWell(
                                    //     onTap: () async {
                                    //       var url = this
                                    //           .data
                                    //           .data["news"][index]["url"]
                                    //           .toString();
                                    //       if (await canLaunch(url)) {
                                    //         await launch(url);
                                    //       } else {
                                    //         throw 'Could not launch $url';
                                    //       }
                                    //     },
                                    //     child: Text(
                                    //         this.data.data["news"][index]["url"],
                                    //         style: TextStyle(
                                    //           decoration:
                                    //               TextDecoration.underline,
                                    //           fontWeight: FontWeight.bold,
                                    //           color: Colors.blue,
                                    //         )),
                                    //   ),
                                    // )
                                  ],
                                )),
                          ),
                        ),
                      );
                    })));
  }
}

class DetailScreen extends StatefulWidget {
  var title;
  var dis;
  var image;
  var link;
  DetailScreen({Key key, this.dis, this.title, this.image, this.link})
      : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: theamColor,
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 300,
              child: Image.network(
                widget.image,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              child: Text(widget.dis),
            ),
          ),
          Center(
            child: Container(
              width: 100,
              child: RaisedButton(
                color: drawerGradient,
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                ),
                onPressed: () async {
                  var url = widget.link;
                  print(url);
                  if (await canLaunch(url))
                    launch(url);
                  else
                    print("error");
                },
                child: Text("More INFO"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
