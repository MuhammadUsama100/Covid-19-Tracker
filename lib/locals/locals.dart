import 'package:coronavirus/Lang/messages_all.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class AppLocations {
  static Future<AppLocations> load(Locale locale) {
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localName = Intl.canonicalizedLocale(name);
    return initializeMessages(localName).then((bool _) {
      Intl.defaultLocale = localName;
      return AppLocations();
    });
  }

  static AppLocations of(BuildContext context) {
    return Localizations.of<AppLocations>(context, AppLocations);
  }

  String get homeScreen {
    return Intl.message("COVID-19", name: "homeScreen", desc: "COVID19Tracker");
  }

  String get pakistanCases {
    return Intl.message("Pakistan Cases",
        name: "pakistanCases", desc: "COVID19Tracker");
  }

  String get profilestatus {
    return Intl.message("Coronavirus Infection",
        name: "profilestatus", desc: "COVID19Tracker");
  }

  String get riskFector {
    return Intl.message("Risk Factor",
        name: "riskFector", desc: "COVID19Tracker");
  }

  String get changeStatus {
    return Intl.message("Change Status",
        name: "changeStatus", desc: "COVID19Tracker");
  }

  String get scanReport {
    return Intl.message("Scan Report",
        name: "scanReport", desc: "COVID19Tracker");
  }

  String get qrcodeStatus {
    return Intl.message("QR Code Status Change",
        name: "qrcodeStatus", desc: "COVID19Tracker");
  }

  String get interaction {
    return Intl.message("Interaction List",
        name: "interaction", desc: "COVID19Tracker");
  }

  String get notifications {
    return Intl.message("Notifications",
        name: "notifications", desc: "COVID19Tracker");
  }

  String get heatmaps {
    return Intl.message("Heat Maps", name: "heatmaps", desc: "COVID19Tracker");
  }

  String get newsFeed {
    return Intl.message("News Feed", name: "newsFeed", desc: "COVID19Tracker");
  }

  String get precautions {
    return Intl.message("Precautions",
        name: "precautions", desc: "COVID19Tracker");
  }

  String get privacypolicy {
    return Intl.message("Privacy Policy",
        name: "privacypolicy", desc: "COVID19Tracker");
  }

  String get scanCodeText {
    return Intl.message("Scan Code to change status",
        name: "scanCodeText", desc: "COVID19Tracker");
  }

  String get threadlevel {
    return Intl.message("Thread Level",
        name: "threadlevel", desc: "COVID19Tracker");
  }

  String get snackbar {
    return Intl.message("Irrelevant Scan",
        name: "snackbar", desc: "COVID19Tracker");
  }

  String get help {
    return Intl.message("Help", name: "help", desc: "COVID19Tracker");
  }

  String get donations {
    return Intl.message("Donations", name: "donations", desc: "COVID19Tracker");
  }

  String get howitworks {
    return Intl.message("How Map Works",
        name: "howitworks", desc: "COVID19Tracker");
  }

  String get howitworksdis {
    return Intl.message(
        "The maps use real time data to keep you updated with the numbers and figures related to Corona Virus. Click on each region to see the the details of specific part of the country.",
        name: "howitworksdis",
        desc: "COVID19Tracker");
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocations> {
  const AppLocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    // TODO: implement isSupported
    return ['ur', 'en'].contains(locale.languageCode);
  }

  @override
  Future<AppLocations> load(Locale locale) {
    return AppLocations.load(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocations> old) {
    return false;
  }
}
