import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:offsetting_mobile/components/map.dart';
import 'package:offsetting_mobile/screens/debug.dart';
import 'package:offsetting_mobile/screens/more/data_sources.dart';

class More extends StatelessWidget {
  const More({super.key});

  @override
  Widget build(BuildContext context) {
    push(Widget route) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => route));
    }

    return Scaffold(
      appBar: AppBar(title: const Text("More")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text("Account"),
              onTap: () => push(const ProfileScreen(
                actions: [],
              )),
            ),
            ListTile(
              leading: const Icon(Icons.wallet),
              title: const Text("Wallet"),
              onTap: () {},
            ),
            const Spacer(flex: 1),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.bug_report),
              title: const Text("Debug"),
              onTap: () => push(const DebugScreen()),
            ),
            ListTile(
              leading: const Icon(Icons.data_array),
              title: const Text("Data Sources"),
              onTap: () => push(const DataSources()),
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text("App Info"),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
