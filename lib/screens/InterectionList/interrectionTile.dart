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
      child: Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: ListTile(
            leading: CircleAvatar(
              child: Container(child: Image.network(widget.logo)),
              radius: 25.0,
            ),
            title: Text(widget.name),
            subtitle: Text(widget.email),
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
