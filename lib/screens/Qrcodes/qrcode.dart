import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

showAlertDialog(BuildContext context, String val, String title) {
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
    content: QrImage(
      data: val,
      version: QrVersions.auto,
      size: 100,
      gapless: false,
    ),
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
