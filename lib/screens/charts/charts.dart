import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:offsetting_mobile/screens/charts/carbon_dioxide.dart';
import 'package:offsetting_mobile/screens/charts/melted_ice_caps.dart';
import 'package:offsetting_mobile/screens/charts/methane.dart';
import 'package:offsetting_mobile/screens/charts/nitrous_oxide.dart';
import 'package:offsetting_mobile/screens/charts/ocean_temperatures.dart';
import 'package:offsetting_mobile/screens/charts/temperature.dart';

class StatsPage {
  final String title;
  final String description;
  final Widget page;

  const StatsPage(
      {required this.title, this.description = "", required this.page});
}

List<StatsPage> stats = const [
  StatsPage(
    title: "Global Temperature Anomalies",
    page: Temperature(),
  ),
  StatsPage(
    title: "Carbon Dioxide",
    page: CarbonDioxide(),
  ),
  StatsPage(
    title: "Methane Levels",
    page: Methane(),
  ),
  StatsPage(
    title: "Nitrous Oxide",
    page: NitrousOxide(),
  ),
  StatsPage(
    title: "Melted Polar Ice Caps",
    page: MeltedIceCaps(),
  ),
  StatsPage(
    title: "Ocean Temperature Anomalies",
    page: OceanTemperatures(),
  ),
];

class Data extends StatelessWidget {
  const Data({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data"),
      ),
      body: ListView(
        children: [
          for (var stat in stats)
            ListTile(
              leading: const Icon(Icons.show_chart),
              title: Text(stat.title),
              subtitle: Text(stat.description),
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (_) => stat.page),
                );
              },
              trailing: const Icon(Icons.arrow_right),
            )
        ],
      ),
    );
  }
}
