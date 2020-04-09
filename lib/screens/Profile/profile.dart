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
                      )
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
          ListTile(
            title: Text("qwertyu"),
          ),
          Divider(
            height: 35,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
