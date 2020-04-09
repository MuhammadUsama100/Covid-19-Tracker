import 'dart:async';
import 'dart:convert';

class CoronaData {
  final String country;
  final int cases;
  final int todayCases;
  final int deaths;
  final int todayDeaths;
  final int recovered;
  final int active;
  final int critical;
  final int casesPerOneMillion;
  final int deathsPerOneMillion;
  final int totalTests;
  final int testsPerOneMillion;
  CoronaData(
      {this.country,
      this.cases,
      this.todayCases,
      this.deaths,
      this.todayDeaths,
      this.recovered,
      this.active,
      this.critical,
      this.casesPerOneMillion,
      this.deathsPerOneMillion,
      this.totalTests,
      this.testsPerOneMillion});

  factory CoronaData.fromJson(Map<String, dynamic> json) {
    return CoronaData(
      country: json["country"] as String,
      cases: json["cases"] as int,
      todayCases: json["todayCases"] as int,
      deaths: json["deaths"] as int,
      todayDeaths: json["todayDeaths"] as int,
      recovered: json["recovered"] as int,
      active: json["active"] as int,
      critical: json["critical"] as int,
      casesPerOneMillion: json["casesPerOneMillion"] as int,
      deathsPerOneMillion: json["deathsPerOneMillion"] as int,
      totalTests: json["totalTests"] as int,
      testsPerOneMillion: json["testsPerOneMillion"] as int,
    );
  }
}
