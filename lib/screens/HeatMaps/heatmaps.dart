import 'dart:async';

import 'dart:ui';

import 'package:coronavirus/constants/constantcolor.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HeatMaps extends StatefulWidget {
  @override
  State<HeatMaps> createState() => HeatMapsState();
}

class HeatMapsState extends State<HeatMaps> {
  Position position;
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  final double long = 0;
  final double lat = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    intial().then((val) {
      setState(() {});
    });
  }

  intial() async {
    position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  @override
  Widget build(BuildContext context) {
    return this.position == null
        ? Container()
        : Scaffold(
            body: GoogleMap(
              polygons: [
                Polygon(
                    strokeWidth: 2,
                    strokeColor: drawerGradient,
                    fillColor: drawerGradient,
                    polygonId: PolygonId("Ploy"),
                    points: [
                      LatLng(24.9217719, 67.120826),
                      LatLng(24.921965, 67.121164),
                      LatLng(24.922543, 67.1206634),
                      LatLng(24.922308, 67.120296)
                    ])
              ].toSet(),
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: LatLng(position.latitude, position.longitude),
                zoom: 14.4746,
              ),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          );
  }
}
