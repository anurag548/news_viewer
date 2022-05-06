import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MakeChart extends StatelessWidget {
  MakeChart({Key? key}) : super(key: key);

  List<Data> _chartData = [
    Data(2017, 25),
    Data(2018, 30),
    Data(2019, 32),
    Data(2020, 22),
    Data(2021, 26),
    Data(2022, 25),
    Data(2023, 27),
    Data(2024, 29),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
            padding: EdgeInsets.all(12),
            child: Container(
              // constraints: BoxConstraints(
              //   maxHeight: 200,
              //   maxWidth: 200,
              // ),
              //color: Colors.amber,
              child: SfCartesianChart(series: <ChartSeries>[
                LineSeries<Data, double>(
                    dataSource: _chartData,
                    xValueMapper: (Data sales, _) => sales.year,
                    yValueMapper: (Data sales, _) => sales.sales),
              ]),
            )));
  }
}

class Data {
  final double year;
  final double sales;
  Data(this.year, this.sales);
}
