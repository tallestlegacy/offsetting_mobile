import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../utils/network.dart';

class MeltedIceCaps extends StatelessWidget {
  const MeltedIceCaps({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Melted Ice Caps"),
      ),
      body: FutureBuilder(
          future: fetch("https://global-warming.org/api/arctic-api"),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SfCartesianChart(
                // Initialize category axis
                primaryXAxis: CategoryAxis(),
                series: <LineSeries<dynamic, String>>[
                  LineSeries<dynamic, String>(
                    // Bind data source
                    dataSource: [
                      for (var stat in snapshot.data["arcticData"]) stat
                    ],
                    xValueMapper: (stat, _) => stat["year"].toString(),
                    yValueMapper: (stat, _) => stat["area"],
                  )
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
