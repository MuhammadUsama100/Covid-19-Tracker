import 'package:coronavirus/constants/constantcolor.dart';
import 'package:coronavirus/locals/locals.dart';
import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: theamColor,
            title: Text(AppLocations.of(context).notifications)),
        body: null);
  }
}
