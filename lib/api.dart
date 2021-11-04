import 'package:http/http.dart' as http;
import 'dart:convert';
import 'story.dart';

class Api {
  String rootUrl = 'https://hacker-news.firebaseio.com/v0/';

  Api() {
    rootUrl = rootUrl;
  }

  Future<http.Response> getTop() {
    return http.get(Uri.parse(rootUrl + 'topstories.json'));
  }

  Future<Story> fetchStory(int id) async {
    Uri requestUrl = Uri.parse(rootUrl + 'item/' + id.toString() + '.json');
    final response = await http.get(requestUrl);

    if (response.statusCode == 200) {
      return Story.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('We fucked up');
    }
  }
}
