import 'package:flutter/material.dart';

class DataSources extends StatelessWidget {
  const DataSources({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sources and References"),
      ),
      body: ListView(
        children: const [
          ListTile(
            leading: Icon(Icons.bar_chart),
            title: Text("https://global-warming.org/"),
            subtitle: Text("Climate change data"),
          ),
          ListTile(
            leading: Icon(Icons.rss_feed_rounded),
            title: Text("https://www.conservation.org/blog/rss-feeds"),
            subtitle: Text("RSS Feed"),
          ),
        ],
      ),
    );
  }
}
