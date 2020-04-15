import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';

Future<void> fetchAlbum() async {
  var response = await http.get(
      'https://en.wikipedia.org/wiki/2020_coronavirus_pandemic_in_Pakistan');
  data(response.body.toString());
}

void data(String data) {
  var document = parse("data");
  print(document.attributes);
}
