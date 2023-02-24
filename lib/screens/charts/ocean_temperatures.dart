import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../utils/network.dart';

class OceanTemperatures extends StatelessWidget {
  const OceanTemperatures({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Global Ocean Temperature Anomalies"),
      ),
      body: FutureBuilder(
          future: fetch("https://global-warming.org/api/ocean-warming-api"),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SfCartesianChart(
                // Initialize category axis
                primaryXAxis: CategoryAxis(),
                series: <LineSeries<dynamic, String>>[
                  LineSeries<dynamic, String>(
                      // Bind data source
                      dataSource: [
                        for (var stat in snapshot.data["result"].entries) stat
                      ],
                      xValueMapper: (stat, _) => stat.key,
                      yValueMapper: (stat, _) => double.parse(stat.value))
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
