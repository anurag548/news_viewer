import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_viewer/newsandcovid/make_chart.dart';
//import 'package:news_viewer/newsandcovid/drawer_menu.dart';

var sendingIndex = 1;

class CovidChart extends StatefulWidget {
  const CovidChart({Key? key}) : super(key: key);

  @override
  State<CovidChart> createState() => _CovidChartState();
}

class _CovidChartState extends State<CovidChart> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: DrawerMenu(),
      appBar: AppBar(
        title: Text('Covid Details'),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) => setState(() {
                currentIndex = index;
                sendingIndex = index;
              }),
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.charging_station), label: "EXAM"),
          ]),
      body: MakeChart(chartIndex: sendingIndex),
    );
  }
}
