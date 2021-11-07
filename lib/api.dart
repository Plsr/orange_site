import 'package:http/http.dart' as http;
import 'dart:convert';
import 'story.dart';

class Api {
  String rootUrl = 'https://hacker-news.firebaseio.com/v0/';

  Api() {
    rootUrl = rootUrl;
  }

  Future<List<Story>> enrichStories(List<int> storyIds) async {
    Iterable<Future<Story>> stories =
        storyIds.map((sotryId) async => await fetchStory(sotryId));
    return Future.wait(stories);
  }

  // TODO: Error hanlding
  Future<List> fetchTopNew() async {
    Uri requestUrl = Uri.parse(rootUrl + 'topstories.json');
    final response = await http.get(requestUrl);

    if (response.statusCode == 200) {
      List ids = jsonDecode(response.body);
      return ids.cast<int>();
    } else {
      throw Exception('we fucked up');
    }
  }

  // TODO: Error hanlding
  Future<Story> fetchStory(int id) async {
    Uri requestUrl = Uri.parse(rootUrl + 'item/' + id.toString() + '.json');
    final response = await http.get(requestUrl);

    if (response.statusCode == 200) {
      Story story = Story.fromJson(jsonDecode(response.body));
      return story;
    } else {
      throw Exception('We fucked up');
    }
  }
}
