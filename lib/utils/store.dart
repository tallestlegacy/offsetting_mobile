import 'package:dart_rss/dart_rss.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'network.dart';

const rssList = [
  'http://feeds.feedburner.com/ConservationInternationalBlog',
];

class FeedsStore extends GetxController {
  var feeds = [].obs;

  getFeeds() async {
    var url = rssList[0];
    var data = await http.get(Uri.parse(url));
    var feed = RssFeed.parse(data.body);

    feeds(feed.items);
  }

  FeedsStore() {
    getFeeds();
  }
}

class ProjectsStore extends GetxController {
  var projects = [].obs;
  init() async {
    List data = await getProjects();
    projects(data);
  }

  dynamic projectFromId(id) {
    return projects.firstWhere((element) => element["id"] == id);
  }

  ProjectsStore() {
    init();
  }
}
