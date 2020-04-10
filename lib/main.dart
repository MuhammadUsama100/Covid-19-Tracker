//import 'package:coronavirus/RegisterUser/registerUser.dart';
import 'dart:async';
import 'package:coronavirus/screens/HomeScreen/homeScreen.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coronavirus/StartScreen/startScreen.dart';
import 'package:coronavirus/Utils/authService.dart';
import 'package:coronavirus/Utils/localStorage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

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

// class HomeScreen extends StatefulWidget {
//   HomeScreen({Key key}) : super(key: key);

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final Firestore _db = Firestore();
//   Timer timer;
//   List listFriends = [];
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     initializeApp();
//     timer = Timer.periodic(Duration(seconds: 50), (Timer t) async {
//       Position position = await Geolocator()
//           .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//       DocumentReference ref =
//           _db.collection("user").document(Storage.getValue("UserID"));

//       ref.updateData({"long": position.longitude, "lat": position.latitude});
//       print(position);

//       QuerySnapshot querySnapshot =
//           await Firestore.instance.collection("user").getDocuments();
//       //print(querySnapshot);
//       querySnapshot.documents.forEach((value) async {
//         print((value["long"] - position.longitude).abs());
//         if ((value["long"] - position.longitude).abs() < 1 &&
//             (value["lat"] - position.latitude).abs() < 1 &&
//             value["email"] != Storage.getValue("UserEmail")) {
//           var friends = await ref.get();
//           List list = friends.data["friends"];
//           bool alreadyFriend = false;
//           print(value["email"]);
//           list.forEach((f) {
//             if (value["email"].toString() == f.toString()) {
//               alreadyFriend = true;
//             }
//           });
//           if (!alreadyFriend) {
//             this.listFriends.add(value["email"]);
//           }
//         }
//       });

//       ref.updateData({"friends": listFriends});
//       setState(() {});
//     });
//   }

//   void initializeApp() async {
//     await Storage.initialize();

//     authService.googleSignIn().then((onValue) async {
//       Position position = await Geolocator()
//           .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//       DocumentReference ref =
//           _db.collection("user").document(Storage.getValue("UserID"));
//       ref.updateData({"long": position.longitude, "lat": position.latitude});
//     });
//   }

//   @override
//   void dispose() {
//     timer?.cancel();
//     super.dispose();
//   }

//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("HomeScreen"),
//       ),
//       body: Container(
//         child: ListView.builder(
//           itemCount: listFriends.length == null ? 1 : listFriends.length,
//           itemBuilder: (BuildContext context, int index) {
//             return listFriends != null
//                 ? Text(listFriends[index].toString())
//                 : Container();
//           },
//         ),
//       ),
//     );
//   }
// }
