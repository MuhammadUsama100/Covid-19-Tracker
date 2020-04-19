import 'package:http/http.dart' as http;
import 'package:coronavirus/StartScreen/startScreen.dart';
import 'package:flutter/material.dart';
import 'Utils/coronaData/coronaService.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StartScreen(),
    );
  }
}

class Test extends StatefulWidget {
  Test({Key key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          print("uasma");
          var data = await fetchCoronaDatas(http.Client());
          data.toList().forEach((f) => print(f.deaths));
        },
      ),
      body: null,
    );
  }
}
