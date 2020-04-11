import 'package:coronavirus/constants/constantcolor.dart';
import 'package:coronavirus/screens/InterectionList/interactionList.dart';
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
          text: "MuhammadUsama",
          gradientCheck: true,
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
          gradientColors: [drawerGradient2, drawerGradient, theamColor],
          avatarradius: 50,
        ),
        DrawerTile(
          name: "InterectionList",
          textOverflow: TextOverflow.ellipsis,
          child: InterctionList(),
          leading: Icon(Icons.people),
          tileSize: 10,
          dividerheight: 5,
          dividerThickness: 1,
          dividercolor: Colors.black,
        ),
        DrawerTile(
          name: "Notifications",
          textOverflow: TextOverflow.ellipsis,
          child: UserProfile(),
          leading: Icon(Icons.notifications),
          tileSize: 10,
          dividerheight: 5,
          dividerThickness: 1,
          dividercolor: Colors.black,
        ),
        DrawerTile(
          name: "NewsFeed",
          textOverflow: TextOverflow.ellipsis,
          child: UserProfile(),
          leading: Icon(Icons.pages),
          tileSize: 10,
          dividerheight: 5,
          dividerThickness: 1,
          dividercolor: Colors.black,
        ),
        DrawerTile(
          name: "Profile",
          textOverflow: TextOverflow.ellipsis,
          child: UserProfile(),
          leading: Icon(Icons.person),
          tileSize: 10,
          dividerheight: 5,
          dividerThickness: 1,
          dividercolor: Colors.black,
        ),
        DrawerTile(
          name: "About",
          textOverflow: TextOverflow.ellipsis,
          child: UserProfile(),
          leading: Icon(Icons.description),
          tileSize: 10,
          dividerheight: 5,
          dividerThickness: 1,
          dividercolor: Colors.black,
        ),
      ],
    );
  }
}
