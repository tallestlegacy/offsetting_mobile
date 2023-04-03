import 'package:flutter/material.dart';
import 'package:dart_rss/dart_rss.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/store.dart';

class Articles extends StatelessWidget {
  const Articles({super.key});

  @override
  Widget build(BuildContext context) {
    var feedsController = Get.put(FeedsStore());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Articles"),
      ),
      body: Obx(
        () => ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            RssItem i = feedsController.feeds[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                  trailing: const Icon(Icons.chevron_right_rounded),
                  title: Text(i.title.toString()),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(i.pubDate.toString()),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(i.description.toString()),
                      ),
                      Wrap(
                        spacing: 8,
                        children: [
                          for (var category in i.categories)
                            Chip(
                              label: Text(
                                category.value.toString(),
                                style: const TextStyle(fontSize: 10),
                              ),
                              visualDensity: VisualDensity.compact,
                            )
                        ],
                      ),
                    ],
                  ),
                  onTap: () async {
                    String _url = i.link.toString();
                    await launchUrl(
                      Uri.parse(_url),
                    );
                  }),
            );
          },
          itemCount: feedsController.feeds.length,
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        ),
      ),
    );
  }
}
