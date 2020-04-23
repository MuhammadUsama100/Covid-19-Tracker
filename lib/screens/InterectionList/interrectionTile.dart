import 'package:coronavirus/constants/constantcolor.dart';
import 'package:flutter/material.dart';

class UserTile extends StatefulWidget {
  var name;
  var email;
  var status;
  var logo;
  UserTile({this.email, this.name, this.status, this.logo});
  // UserTile({Key key}) : super(key: key);

  @override
  _UserTileState createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
          elevation: 10,
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: ListTile(
            title: Text(widget.email),
            trailing: Container(
                width: 50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Status"),
                    Text(widget.status),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
