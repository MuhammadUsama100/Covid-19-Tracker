import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coronavirus/Models/tracker.dart';
import 'package:coronavirus/Utils/localStorage.dart';

void updateCoordinates(Firestore _db) {
  DocumentReference ref =
      _db.collection("user").document(Storage.getValue("UserID"));
  ref.updateData({"data": Storage.getlocal("Local")});
}

Future<void> positionCheck(Firestore _db) async {
  DocumentReference ref =
      _db.collection("user").document(Storage.getValue("UserID"));
  DocumentSnapshot user = await ref.get();
  var userList = user["data"];
  QuerySnapshot querySnapshot =
      await Firestore.instance.collection("user").getDocuments();
  querySnapshot.documents.forEach((doc) {
    var list = doc["data"];
    for (int i = 0; i < list.length; i++) {
      Track alluser = Storage.parse(list[i]);
      for (int j = 0; j < userList.length; j++) {
        Track currentuser = Storage.parse(userList[j]);

        if (compare(currentuser, alluser) && doc["email"] != user["email"]) {
          var friends = user["friends"];
          bool alreadyFriend = false;
          bool statusUpdate = false;
          for (int k = 0; k < friends.length; k++) {
            if (friends[k]["email"] == doc["email"]) {
              alreadyFriend = true;
              if (friends[k]["status"] != doc["status"]) statusUpdate = true;
            }
          }
          if (!alreadyFriend) {
            friends.add({
              "email": doc["email"],
              "status": doc["status"],
              "id": doc.documentID
            });
            ref.updateData({"friends": friends});
          }
          if (statusUpdate) {
            for (int k = 0; k < friends.length; k++) {
              if (friends[k]["email"] == doc["email"]) {
                if (friends[k]["status"] != doc["status"]) {
                  friends[k]["status"] = doc["status"];
                }
              }
            }
            ref.updateData({"friends": friends});
          }
          // all comapre done  ;
        }
      }
    }
  });
}
// 3 way comparison

bool compare(Track user, Track alluser) {
  var userlat = double.parse(user.lat);
  assert(userlat is double);

  var userlong = double.parse(user.long);
  assert(userlong is double);

  var useralti = double.parse(user.altitute);
  assert(useralti is double);

  DateTime usertime = DateTime.parse(user.time);
  assert(usertime is DateTime);
// all users
  var alluserlat = double.parse(alluser.lat);
  assert(alluserlat is double);

  var alluserlong = double.parse(alluser.long);
  assert(alluserlong is double);

  var alluseralti = double.parse(alluser.altitute);
  assert(alluseralti is double);

  DateTime allusertime = DateTime.parse(alluser.time);
  //assert(allusertime is DateTime);

  if ((userlat - alluserlat).abs() < 10 &&
      (userlong - alluserlong).abs() < 10 &&
      (useralti - alluseralti).abs() < 4 &&
      (usertime.millisecondsSinceEpoch - allusertime.millisecondsSinceEpoch)
              .abs() <
          100) {
    return true;
  } else {
    return false;
  }
}

// submit = Timer.periodic(Duration(seconds: 30), (Timer t) async {
//   DocumentReference ref =
//       _db.collection("user").document(Storage.getValue("UserID"));

//   ref.updateData({"data": Storage.getlocal("Local")});
//   QuerySnapshot querySnapshot =
//       await Firestore.instance.collection("user").getDocuments();
//   querySnapshot.documents.forEach((doc) {
//     List list = doc["data"];
//     List localList = Storage.getlocal("Local");
//     list.forEach((val) {
//       Track tack = Storage.parse(val.toString());
//       localList.forEach((locVal) async {
//         // print("object");
//         Track localtack = Storage.parse(locVal.toString());
//         // print(localtack.time);
//         if ((DateTime.parse(localtack.time).millisecondsSinceEpoch -
//                     DateTime.parse(tack.time).millisecondsSinceEpoch)
//                 .abs() <
//             1000) {
//           // print("usama1");
//           var latlocal = double.parse(localtack.lat);
//           assert(latlocal is double);
//           var longlocal = double.parse(localtack.lat);
//           assert(longlocal is double);
//           var lat = double.parse(localtack.lat);
//           assert(lat is double);
//           var long = double.parse(localtack.lat);
//           assert(long is double);
//           // print(long);

//           if ((latlocal - lat).abs() < 3 &&
//               (longlocal - long).abs() < 3 &&
//               doc["email"] != Storage.getValue("UserEmail")) {
//             // print("usama1");
//             // print("usama1");

//             // add to list  ;

//             var friends = await ref.get();
//             List list = friends.data["friends"];
//             bool alreadyFriend = false;
//             // print(doc["email"]);
//             alreadyFriend = false;

//             list.forEach((f) {
//               if (doc["email"].toString() == f.email.toString()) {
//                 alreadyFriend = true;
//               }
//             });

//             // print(alreadyFriend);
//             if (!alreadyFriend) {
//               list.add({
//                 "logo": doc["logo"],
//                 "name": doc["name"],
//                 "email": doc["email"],
//                 "status": doc["status"]
//               });
//               list.forEach((f) {
//                 this.friend.add(f);
//               });
//             } else {
//               //print("usama");
//               this.friend.forEach((f) {
//                 if (doc["email"].toString() == f.email.toString()) {
//                   this.friend.remove(f);
//                 }
//               });
//               list.forEach((f) {
//                 if (doc["email"].toString() == f.email.toString()) {
//                   f.status = doc["status"];
//                 }
//               });
//             }
//           }
//           //time compared
//           print("part1");
//         }
//       });
//     });
//   });
