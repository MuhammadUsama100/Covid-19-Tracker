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

Future<CoronaData> fetchPost() async {
  final response =
      await http.get('https://coronavirus-19-api.herokuapp.com/countries');
  if (response.statusCode == 200) {
    return CoronaData.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load post');
  }
}
