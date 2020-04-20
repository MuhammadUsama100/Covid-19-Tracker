import 'dart:async';

import 'package:coronavirus/constants/constantcolor.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HeatMaps extends StatefulWidget {
  @override
  State<HeatMaps> createState() => HeatMapsState();
}

class HeatMapsState extends State<HeatMaps> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Completer<WebViewController> controller = Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: theamColor, title: Text("Heat Maps")),
      body: WebView(
        initialUrl: "http://13.229.231.75:9000/",
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController controllers) {
          controller.complete(controllers);
        },
      ),
    );
  }
}
