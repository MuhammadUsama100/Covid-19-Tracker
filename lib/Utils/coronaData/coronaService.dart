import 'dart:convert';

import 'package:coronavirus/Models/coronaData.dart';
import 'package:http/http.dart' as http;

// A function that converts a response body into a List<CoronaData>.
List<CoronaData> parseCoronaDatas(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<CoronaData>((json) => CoronaData.fromJson(json)).toList();
}

Future<List<CoronaData>> fetchCoronaDatas(http.Client client) async {
  final response =
      await client.get('https://coronavirus-19-api.herokuapp.com/countries');

  return parseCoronaDatas(response.body);
}
