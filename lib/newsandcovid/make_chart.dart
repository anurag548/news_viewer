import 'package:flutter/material.dart';
import 'package:news_viewer/models/covid_chart_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MakeChart extends StatefulWidget {
  int chartIndex;
  MakeChart({Key? key, required this.chartIndex}) : super(key: key);

  State<MakeChart> createState() => _MakeChartState();
}

class _MakeChartState extends State<MakeChart> {
  List<Data> _chartData = <Data>[];
  bool _isLoading = true;

  @override
  void initState() {
    getChartData();
    super.initState();
  }

  getChartData() async {
    CovidData cd = CovidData();
    await cd.getData();
    _chartData = cd.gotdata;
    setState(() {
      _isLoading = false;
    });
    //print((Data dd) => dd.dateymd);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
            padding: EdgeInsets.all(12),
            child: Container(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : selectChart(widget.chartIndex)
                // : SfCartesianChart(
                //     zoomPanBehavior: ZoomPanBehavior(enablePanning: true),
                //     primaryYAxis: NumericAxis(interval: 2500000),
                //     primaryXAxis: DateTimeAxis(interval: 1),
                //     series: <ChartSeries<Data, DateTime>>[
                //       AreaSeries<Data, DateTime>(
                //         animationDuration: 3500,
                //         animationDelay: 2000,
                //         dataSource: _chartData,
                //         xValueMapper: (Data cd, _) => cd.dateymd,
                //         yValueMapper: (Data cd, _) => cd.totalConfirmed,
                //         borderGradient: const LinearGradient(colors: <Color>[
                //           Color.fromRGBO(230, 0, 180, 1),
                //           Color.fromRGBO(255, 200, 0, 1)
                //         ], stops: <double>[
                //           0.2,
                //           0.9
                //         ]),
                //       ),
                //       AreaSeries<Data, DateTime>(
                //         animationDuration: 3500,
                //         animationDelay: 2000,
                //         dataSource: _chartData,
                //         xValueMapper: (Data cd, _) => cd.dateymd,
                //         yValueMapper: (Data cd, _) => cd.totalRecovered,
                //         borderGradient: const LinearGradient(colors: <Color>[
                //           Color.fromRGBO(230, 0, 180, 1),
                //           Color.fromRGBO(255, 200, 0, 1)
                //         ], stops: <double>[
                //           0.2,
                //           0.9
                //         ]),
                //       ),
                //       AreaSeries<Data, DateTime>(
                //         animationDuration: 3500,
                //         animationDelay: 2000,
                //         dataSource: _chartData,
                //         xValueMapper: (Data cd, _) => cd.dateymd,
                //         yValueMapper: (Data cd, _) => cd.totalDeceased,
                //         borderGradient: const LinearGradient(colors: <Color>[
                //           Color.fromRGBO(230, 0, 180, 1),
                //           Color.fromRGBO(255, 200, 0, 1)
                //         ], stops: <double>[
                //           0.2,
                //           0.9
                //         ]),
                //       ),
                //     ],
                //   ),
                )));
  }

  Widget selectChart(int index) {
    switch (index) {
      case 1:
        return SfCartesianChart(
          zoomPanBehavior: ZoomPanBehavior(enablePanning: true),
          primaryYAxis: NumericAxis(interval: 2500000),
          primaryXAxis: DateTimeAxis(interval: 1),
          series: <ChartSeries<Data, DateTime>>[
            AreaSeries<Data, DateTime>(
              animationDuration: 3500,
              animationDelay: 2000,
              dataSource: _chartData,
              xValueMapper: (Data cd, _) => cd.dateymd,
              yValueMapper: (Data cd, _) => cd.totalConfirmed,
              borderGradient: const LinearGradient(colors: <Color>[
                Color.fromRGBO(230, 0, 180, 1),
                Color.fromRGBO(255, 200, 0, 1)
              ], stops: <double>[
                0.2,
                0.9
              ]),
            ),
            AreaSeries<Data, DateTime>(
              animationDuration: 3500,
              animationDelay: 2000,
              dataSource: _chartData,
              xValueMapper: (Data cd, _) => cd.dateymd,
              yValueMapper: (Data cd, _) => cd.totalRecovered,
              borderGradient: const LinearGradient(colors: <Color>[
                Color.fromRGBO(230, 0, 180, 1),
                Color.fromRGBO(255, 200, 0, 1)
              ], stops: <double>[
                0.2,
                0.9
              ]),
            ),
            AreaSeries<Data, DateTime>(
              animationDuration: 3500,
              animationDelay: 2000,
              dataSource: _chartData,
              xValueMapper: (Data cd, _) => cd.dateymd,
              yValueMapper: (Data cd, _) => cd.totalDeceased,
              borderGradient: const LinearGradient(colors: <Color>[
                Color.fromRGBO(230, 0, 180, 1),
                Color.fromRGBO(255, 200, 0, 1)
              ], stops: <double>[
                0.2,
                0.9
              ]),
            ),
          ],
        );
      case 2:
        return SfCartesianChart(
          zoomPanBehavior: ZoomPanBehavior(enablePanning: true),
          primaryYAxis: NumericAxis(interval: 2500000),
          primaryXAxis: DateTimeAxis(interval: 1),
          series: <CircularSeries<Data, DateTime>>[
            PieSeries<Data, DateTime>(
              animationDuration: 3500,
              animationDelay: 2000,
              dataSource: _chartData,
              xValueMapper: (Data cd, _) => cd.dateymd,
              yValueMapper: (Data cd, _) => cd.totalConfirmed,
            ),
          ],
        );
      default:
        return SfCircularChart(
          // zoomPanBehavior: ZoomPanBehavior(enablePanning: true),
          // primaryYAxis: NumericAxis(interval: 2500000),
          // primaryXAxis: DateTimeAxis(interval: 1),
          series: <CircularSeries<Data, DateTime>>[
            PieSeries<Data, DateTime>(
              animationDuration: 3500,
              animationDelay: 2000,
              dataSource: _chartData,
              xValueMapper: (Data cd, _) => cd.dateymd,
              yValueMapper: (Data cd, _) => cd.totalConfirmed,
            ),
          ],
        );
    }
  }
}
