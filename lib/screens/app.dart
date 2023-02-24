import 'package:flutter/material.dart';

import 'credits.dart';
import 'projects/projects.dart';
import 'charts/charts.dart';
import 'more/more.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      const Projects(),
      const Data(),
      const Credits(),
      const More(),
    ];
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: NavigationBar(
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.explore_rounded),
              label: 'Projects',
            ),
            NavigationDestination(
              icon: Icon(Icons.bar_chart_rounded),
              label: 'Data',
            ),
            NavigationDestination(
              icon: Icon(Icons.credit_card_rounded),
              label: 'Credits',
            ),
            NavigationDestination(
              icon: Icon(Icons.more_horiz_rounded),
              label: 'More',
            ),
          ],
          selectedIndex: _selectedIndex,
          onDestinationSelected: (value) {
            setState(() {
              _selectedIndex = value;
            });
          }),
    );
  }
}
