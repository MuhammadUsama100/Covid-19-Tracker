import 'package:coronavirus/constants/constantcolor.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  UserProfile({Key key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
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
                    backgroundImage: NetworkImage(
                        "https://pbs.twimg.com/profile_images/1141781661551665153/BMnvVd2u_400x400.jpg"),
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
                      Text("Muhammad Usama",
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                      Text("UsamaMuhamamd833@gmail.com",
                          style: TextStyle(color: Colors.white)),
                      Row(
                        children: <Widget>[
                          Text("Status : ",
                              style: TextStyle(color: Colors.white)),
                          Text("No Corona  ",
                              style: TextStyle(color: Colors.white)),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Container(
                              width: 10,
                              height: 10,
                              decoration: new BoxDecoration(
                                color: Colors.lightGreen,
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
                          Text("ZERO", style: TextStyle(color: Colors.white)),
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
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
            child: Card(
              elevation: 2,
              child: Container(
                height: 85,
                child: Center(
                  child: ListTile(
                    leading: Icon(Icons.insert_chart),
                    title: Text("Change Status",
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
