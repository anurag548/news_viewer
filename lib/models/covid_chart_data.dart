import 'package:news_viewer/services/base_client.dart';

class CovidData {
  List<Data> gotdata = [];

  getData() async {
    var result =
        await BaseClient().get('https://data.covid19india.org', '/data.json');
    if (result['cases_time_series'] != null) {
      print("!!!-----------Recieved Chart Data----------!!!");
      result['cases_time_series'].forEach((element) {
        if (element['date'] != null) {
          Data data = Data(
              int.parse(element['totalconfirmed']),
              int.parse(element['totalrecovered']),
              int.parse(element['totaldeceased']),
              element['dateymd']);
          gotdata.add(data);
        }
      });
    } else {
      print('!!!-----------NO DATA RECIEVED----------!!!');
    }
  }
}

class Data {
  int totalRecovered;
  int totalConfirmed;
  int totalDeceased;
  String dateymd;
  Data(this.totalConfirmed, this.totalRecovered, this.totalDeceased,
      this.dateymd);
}
