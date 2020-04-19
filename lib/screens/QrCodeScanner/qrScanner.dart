import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

Future<String> scan() async {
  try {
    var qr = await BarcodeScanner.scan();

    return qr.toString();
  } on PlatformException catch (e) {
    if (e.code == BarcodeScanner.CameraAccessDenied) {
      return 'Camara Permission Denied';
    } else {
      return "Unknown Error Please Try Again";
    }
  } on FormatException {
    return 'Scanning Incomplete';
  } catch (x) {
    return "Unknown Error Please Try Again";
  }
}
