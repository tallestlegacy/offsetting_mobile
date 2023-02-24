import 'package:flutter/material.dart';
import 'package:offsetting_mobile/utils/network.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Temperature extends StatelessWidget {
  const Temperature({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Temperature Anomalies"),
      ),
      body: FutureBuilder(
          future: fetch("https://global-warming.org/api/temperature-api"),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                series: <LineSeries<dynamic, String>>[
                  LineSeries<dynamic, String>(
                      // Bind data source
                      dataSource: [
                        for (var stat in snapshot.data["result"]) stat
                      ],
                      xValueMapper: (stat, _) => stat["time"],
                      yValueMapper: (stat, _) => double.parse(stat["land"]))
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
