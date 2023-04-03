import 'package:flutter/material.dart';

class AppInfo extends StatelessWidget {
  const AppInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("App Info"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: const [
          Text("This is a carbon crediting and offset tracking  application"),
        ],
      ),
    );
  }
}
