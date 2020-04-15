import 'package:coronavirus/Utils/localStorage.dart';
import 'package:coronavirus/constants/constantcolor.dart';
import 'package:coronavirus/screens/InterectionList/interactionList.dart';
import 'package:coronavirus/screens/NewsFeeds/newsFeeds.dart';
import 'package:coronavirus/screens/PakistanMap/pakistanMap.dart';
import 'package:coronavirus/screens/Precautions/precautions.dart';
import 'package:coronavirus/screens/Profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:drawer_component/drawer_component.dart';
import 'package:coronavirus/screens/Donations/Donations.dart';

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
          circleAvatarImageurl: Storage.getValue("Image"),
          checkNetworkAssets: true,
          color: Colors.blue,
          text: Storage.getValue("UserName"),
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
          child: NewesFeeds(),
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
        DrawerTile(
          name: "Pakistan Corona",
          textOverflow: TextOverflow.ellipsis,
          child: PakistanMap(),
          leading: Icon(Icons.description),
          tileSize: 10,
          dividerheight: 5,
          dividerThickness: 1,
          dividercolor: Colors.black,
        ),
        DrawerTile(
          name: "Pakistan Corona",
          textOverflow: TextOverflow.ellipsis,
          child: DonationsScreen(),
          leading: Icon(Icons.description),
          tileSize: 10,
          dividerheight: 5,
          dividerThickness: 1,
          dividercolor: Colors.black,
        ),
        DrawerTile(
          name: "Precautions",
          textOverflow: TextOverflow.ellipsis,
          child: Precautions(),
          leading: Icon(Icons.description),
          tileSize: 10,
          dividerheight: 5,
          dividerThickness: 1,
          dividercolor: Colors.black,
        ),
        DrawerTile(
          name: "Entertainment",
          textOverflow: TextOverflow.ellipsis,
          child: Precautions(),
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
