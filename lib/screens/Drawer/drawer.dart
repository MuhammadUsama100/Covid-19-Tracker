import 'package:coronavirus/screens/Profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:drawer_component/drawer_component.dart';

class DrawerScreen extends StatefulWidget {
  DrawerScreen({Key key}) : super(key: key);

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        DrawerLogo(
          avatarBackgroundColor: Colors.white,
          circleAvatarImageurl:
              "https://i.ytimg.com/vi/sK-8k1Dq1xM/hqdefault.jpg",
          checkNetworkAssets: true,
          color: Colors.blue,
          text: "qwerty",
          gradientCheck: true,
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
          gradientColors: [Colors.red, Colors.blue],
          avatarradius: 50,
        ),
        DrawerTile(
          name: "call",
          textOverflow: TextOverflow.ellipsis,
          child: UserProfile(),
          leading: Icon(Icons.call),
          tileSize: 10,
          dividerheight: 5,
          dividerThickness: 1,
          dividercolor: Colors.black,
        ),
      ],
    );
  }
}
