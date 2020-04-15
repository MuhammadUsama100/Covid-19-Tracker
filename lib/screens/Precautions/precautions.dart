import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coronavirus/constants/constantcolor.dart';
import 'package:flutter/material.dart';

class Precautions extends StatefulWidget {
  Precautions({Key key}) : super(key: key);

  @override
  _PrecautionsState createState() => _PrecautionsState();
}

class _PrecautionsState extends State<Precautions> {
  var data;
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
        _db.collection("safe").document("JrYCELYsaK3pBa4wxWtE");

    this.data = await ref.get();
    print("USAMA");

    print(this.data["safe"].length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: theamColor,
          title: Text('Precautions'),
        ),
        body: this.data == null
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: this.data["safe"].length,
                itemBuilder: (context, int index) {
                  return Center(
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Text(this.data["safe"][index]["title"],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17)),
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 200,
                                    height: 200,
                                    decoration:
                                        BoxDecoration(shape: BoxShape.circle),
                                    child: GestureDetector(
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        child: Image.network(
                                          this.data["safe"][index]["url"],
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailScreen(
                                                    url: this.data["safe"]
                                                        [index]["url"],
                                                    title: this.data["safe"]
                                                        [index]["title"],
                                                    dis: this.data["safe"]
                                                        [index]["dis"],
                                                  )),
                                        );
                                      },
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }));
  }
}

class DetailScreen extends StatefulWidget {
  var dis;
  var title;
  var url;

  DetailScreen({this.dis, this.title, this.url});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 100.0, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(widget.title,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Container(
              child: GestureDetector(
                child: Center(
                  child: Image.network(
                    widget.url,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Container(width: 300, child: Text(widget.dis))
          ],
        ),
      ),
    );
  }
}
