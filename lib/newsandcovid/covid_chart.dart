import 'package:flutter/material.dart';
import 'package:news_viewer/newsandcovid/drawer_menu.dart';
import 'package:news_viewer/newsandcovid/make_chart.dart';

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
      body: const MakeChart(),
      // bottomNavigationBar: BottomNavigationBar(items: [
      //   BottomNavigationBarItem(
      //     icon: IconButton(
      //         onPressed: () => {print('Line Chart')},
      //         icon: Icon(Icons.line_axis)),
      //     label: 'Line Chart',
      //   ),
      //   BottomNavigationBarItem(
      //     icon: IconButton(
      //         onPressed: () => {print('Pie Chart')},
      //         icon: Icon(Icons.line_axis)),
      //     label: 'Line Chart',
      //   ),
      // ]),
    );
  }
}
