import 'package:flutter/material.dart';
import 'package:news_viewer/newsandcovid/make_chart.dart';
//import 'package:news_viewer/newsandcovid/drawer_menu.dart';

class CovidChart extends StatefulWidget {
  const CovidChart({Key? key}) : super(key: key);

  @override
  State<CovidChart> createState() => _CovidChartState();
}

class _CovidChartState extends State<CovidChart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: DrawerMenu(),
      appBar: AppBar(
        title: Text('Covid Details'),
        centerTitle: true,
      ),
      body: MakeChart(),
    );
  }
}
