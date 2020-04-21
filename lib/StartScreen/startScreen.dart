import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coronavirus/Utils/authService.dart';
import 'package:coronavirus/Utils/localStorage.dart';
import 'package:coronavirus/screens/HomeScreen/homeScreen.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final Firestore _db = Firestore();

  bool _isSignedIn = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<bool> initializeApp() async {
    print("USAMA");

    await Storage.initialize();

    await authService.googleSignIn();
    DocumentReference ref =
        _db.collection("user").document(Storage.getValue("UserID"));
    var data = await ref.get();
    List<String> list = [];
    for (int i = 0; i < data["data"].length; i++) {
      list.add(data["data"][i].toString());
    }
    Storage.setlocal("Local", list);
    print("USAMA");
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SplashScreen.callback(
      name: 'assets/NewFile.flr',
      onSuccess: (dynamic data) async {
        print("object");
        if (await initializeApp()) {
          _isSignedIn = true;
          _changeScreen();
        }
      },
      onError: (dynamic error, dynamic stacktrace) {
        // _changeScreen();
      },
      until: () => Future.delayed(Duration(seconds: 5)),
      startAnimation: 'Untitled',
    ));
  }

  void _changeScreen() {
    if (_isSignedIn) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      setState(() {});
    }
  }
}

// class StartScreen extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return StartScreenState();
//   }
// }

// class StartScreenState extends State<StartScreen> {
//   bool _isSignedIn = false;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();

//     initializeApp().then((isInitialized) {
//       FirebaseAuth.instance.onAuthStateChanged.first.then((FirebaseUser user) {
//         if (user != null) {
//           Config.currentUser = user;
//           print("signed in");
//           //  print(user.email);
//           _isSignedIn = true;

//           RequestManager().getClasses(email: user.email);
//         } else {
//           print("signed out");
//           _isSignedIn = false;
//         }
//       });
//     });
//   }

//   initializeApp() async {
//     await StorageHandler.initialize();
//     await fetchRemoteConfig();
//     await RequestManager().getClasses(email: "shakeebsiddiqui1998@gmail.com");
//     return true;
//   }

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Scaffold(
//         body: SplashScreen.callback(
//       name: 'assets/splashScreen.flr',
//       onSuccess: (dynamic data) {
//         _changeScreen();
//       },
//       onError: (dynamic error, dynamic stacktrace) {
//         _changeScreen();
//       },
//       until: () => Future.delayed(Duration(seconds: 5)),
//       startAnimation: '1',
//     ));
//   }

//   void _changeScreen() {
//     if (_isSignedIn) {
//       Navigator.of(context).pushReplacement(
//           new MaterialPageRoute(builder: (context) => HomeScreen()));
//     } else {
//       Navigator.of(context).pushReplacement(new MaterialPageRoute(
//           builder: (context) => Container(
//                 child: Center(
//                   child: RaisedButton(
//                     onPressed: () async {
//                       FirebaseUser user = await signInWithGoogle();
//                       Config.currentUser = user;

//                       RequestManager()
//                           .getClasses(email: user.email)
//                           .then((value) {
//                         Navigator.of(context).pushReplacement(
//                             new MaterialPageRoute(
//                                 builder: (context) => HomeScreen()));
//                       });
//                     },
//                     child: Text("Sign in with Google"),
//                   ),
//                 ),
//               )));
//     }
//   }
// }
