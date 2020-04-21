import 'package:coronavirus/Utils/localStorage.dart';
import 'package:coronavirus/constants/constantcolor.dart';
import 'package:coronavirus/locals/locals.dart';
import 'package:coronavirus/screens/Developers/developers.dart';
import 'package:coronavirus/screens/HeatMaps/heatmaps.dart';
import 'package:coronavirus/screens/InterectionList/interactionList.dart';
import 'package:coronavirus/screens/NewsFeeds/newsFeeds.dart';
import 'package:coronavirus/screens/Notifications/notifications.dart';
import 'package:coronavirus/screens/PakistanMap/pakistanMap.dart';
import 'package:coronavirus/screens/Policy/privatePolicy.dart';
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
          name: "Profile",
          textOverflow: TextOverflow.ellipsis,
          child: UserProfile(),
          leading: Icon(Icons.person),
          tileSize: 10,
          dividerheight: 5,
          dividerThickness: 0.3,
          dividercolor: Colors.black,
        ),
        DrawerTile(
          name: AppLocations.of(context).interaction,
          textOverflow: TextOverflow.ellipsis,
          child: InterctionList(),
          leading: Icon(Icons.people),
          tileSize: 10,
          dividerheight: 5,
          dividerThickness: 0.3,
          dividercolor: Colors.black,
        ),
        DrawerTile(
          name: AppLocations.of(context).notifications,
          textOverflow: TextOverflow.ellipsis,
          child: Notifications(),
          leading: Icon(Icons.notifications),
          tileSize: 10,
          dividerheight: 5,
          dividerThickness: 0.3,
          dividercolor: Colors.black,
        ),
        DrawerTile(
          name: AppLocations.of(context).heatmaps,
          textOverflow: TextOverflow.ellipsis,
          child: HeatMaps(),
          leading: Icon(Icons.map),
          tileSize: 10,
          dividerheight: 5,
          dividerThickness: 0.3,
          dividercolor: Colors.black,
        ),
        DrawerTile(
          name: AppLocations.of(context).newsFeed,
          textOverflow: TextOverflow.ellipsis,
          child: NewesFeeds(),
          leading: Icon(Icons.pages),
          tileSize: 10,
          dividerheight: 5,
          dividerThickness: 0.3,
          dividercolor: Colors.black,
        ),
        DrawerTile(
          name: AppLocations.of(context).precautions,
          textOverflow: TextOverflow.ellipsis,
          child: Precautions(),
          leading: Icon(Icons.error_outline),
          tileSize: 10,
          dividerheight: 5,
          dividerThickness: 0.3,
          dividercolor: Colors.black,
        ),
        DrawerTile(
          name: AppLocations.of(context).privacypolicy,
          textOverflow: TextOverflow.ellipsis,
          child: PrivacyPolicy(),
          leading: Icon(Icons.stop_screen_share),
          tileSize: 10,
          dividerheight: 5,
          dividerThickness: 0.3,
          dividercolor: Colors.black,
        ),
      ],
    );
  }
}
