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
            leading: Icon(Icons.api),
            title: Text("https://global-warming.org/"),
            subtitle: Text("Climate change data"),
          )
        ],
      ),
    );
  }
}
