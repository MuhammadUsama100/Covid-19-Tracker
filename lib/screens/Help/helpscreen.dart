import 'package:flutter/material.dart';

showAlertHelp(BuildContext context, String title) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(
        "The maps use real time data to keep you updated with the numbers and figures related to Corona Virus Click on each region to see the the details of specific part of the country."),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
