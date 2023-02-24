import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../utils/network.dart';

class CarbonDioxide extends StatelessWidget {
  const CarbonDioxide({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Carbon Dioxide"),
      ),
      body: FutureBuilder(
          future: fetch("https://global-warming.org/api/co2-api"),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SfCartesianChart(
                // Initialize category axis
                primaryXAxis: CategoryAxis(),
                series: <LineSeries<dynamic, String>>[
                  LineSeries<dynamic, String>(
                      // Bind data source
                      dataSource: [for (var stat in snapshot.data["co2"]) stat],
                      xValueMapper: (stat, _) =>
                          "${stat['month']}-${stat["year"]}",
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
