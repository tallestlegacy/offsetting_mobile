import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../utils/network.dart';

class Methane extends StatelessWidget {
  const Methane({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Methane"),
      ),
      body: FutureBuilder(
          future: fetch("https://global-warming.org/api/methane-api"),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              snapshot.data["methane"].removeAt(0);
              return SfCartesianChart(
                // Initialize category axis
                primaryXAxis: CategoryAxis(),
                series: <LineSeries<dynamic, String>>[
                  LineSeries<dynamic, String>(
                      // Bind data source
                      dataSource: [
                        for (var stat in snapshot.data["methane"]) stat
                      ],
                      xValueMapper: (stat, _) => stat["date"],
                      yValueMapper: (stat, _) => double.parse(stat["trend"]))
                ],
              );
            }

            return Column(
              children: const [
                LinearProgressIndicator(),
              ],
            );
          }),
    );
  }
}
