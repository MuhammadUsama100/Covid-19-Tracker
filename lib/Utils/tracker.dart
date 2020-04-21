import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coronavirus/Models/threadmodel.dart';
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
  var userList = await user["data"];
  QuerySnapshot querySnapshot =
      await Firestore.instance.collection("user").getDocuments();
  querySnapshot.documents.forEach((doc) async {
    if (doc != null) {
      var list = await doc["data"];
      for (int i = 0; i < list.length; i++) {
        Track alluser = Storage.parse(list[i]);
        for (int j = 0; j < userList.length; j++) {
          Track currentuser = Storage.parse(userList[j]);

          if (compare(currentuser, alluser) && doc["email"] != user["email"]) {
            var friends = user["friends"];
            bool alreadyFriend = false;
            bool threadchange = false;
            bool statusUpdate = false;
            bool updateDate = false;
            for (int k = 0; k < friends.length; k++) {
              DateTime usertime = DateTime.parse(currentuser.time);
              assert(usertime is DateTime);
              if (friends[k]["email"] == doc["email"]) {
                alreadyFriend = true;
                if (friends[k]["status"] != doc["status"])
                  statusUpdate = true;
                else if (friends[k]["date"] < usertime.day) {
                  for (int k = 0; k < friends.length; k++) {
                    if (friends[k]["email"] == doc["email"]) {
                      if (friends[k]["date"] < doc["date"]) {
                        friends[k]["date"] = usertime.day;
                      }
                    }
                  }
                  ref.updateData({"friends": friends});
                } else if (friends[k]["thread"]["percent"] !=
                    doc["thread"]["percent"]) threadchange = true;
              }
            }
            if (!alreadyFriend) {
              friends.add({
                "check": 0,
                "email": doc["email"],
                "status": doc["status"],
                "id": doc.documentID,
                "date": DateTime.now().day,
                "thread": {
                  "percent": 0,
                  "threadDate": DateTime.now().day,
                },
              });
              ref.updateData({"friends": friends});
            }

            if (statusUpdate) {
              for (int k = 0; k < friends.length; k++) {
                if (friends[k]["email"] == doc["email"]) {
                  if (friends[k]["status"] != doc["status"]) {
                    friends[k]["status"] = doc["status"];
                    friends[k]["check"] = 0;
                  }
                }
              }
              ref.updateData({"friends": friends});
            }
            if (threadchange) {
              for (int k = 0; k < friends.length; k++) {
                if (friends[k]["email"] == doc["email"]) {
                  if (friends[k]["thread"]["percent"] !=
                      doc["thread"]["percent"]) {
                    friends[k]["thread"]["percent"] = doc["thread"]["percent"];
                  }
                }
              }
              ref.updateData({"friends": friends});
            }
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

  if ((userlat - alluserlat).abs() < 1 &&
      (userlong - alluserlong).abs() < 1 &&
      (useralti - alluseralti).abs() < 10 &&
      (usertime.millisecondsSinceEpoch - allusertime.millisecondsSinceEpoch)
              .abs() <
          8000) {
    return true;
  } else {
    return false;
  }
}
// 14 classification

Future<void> threadLevelClassifier(Firestore _db) async {
  int count = 1;
  print("anas");
  DocumentReference ref =
      _db.collection("user").document(Storage.getValue("UserID"));
  print("anas1");
  DocumentSnapshot user = await ref.get();
  var percent = user["thread"]["percent"];
  var list = await user["friends"];
  for (int i = 0; i < list.length; i++) {
    DocumentReference refx = _db.collection("user").document(list[i]["id"]);
    DocumentSnapshot data = await refx.get();
    var val = list[i]["thread"]["percent"].toDouble();
    assert(val is double);
    var check = list[i]["check"].toInt();
    assert(check is int);
    //assert(check is bool);

    // if (list[i]["date"] > data["thread"]["date"] &&
    if (val != 0 && check == 0) {
      count++;
      list[i]["check"] = 1;
      percent = percent + val;
    }
    print("anas2");
  }
  percent = (percent / (count * 100)) * 100;
  print(percent);
  ref.updateData({
    "thread": {"percent": percent, "threadDate": DateTime.now().day}
  });
  ref.updateData({"friends": list});
}
