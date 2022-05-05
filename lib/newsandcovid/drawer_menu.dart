import 'package:flutter/material.dart';
import 'package:news_viewer/newsandcovid/covid_chart.dart';
import 'package:news_viewer/newsandcovid/default_home.dart';
import 'package:news_viewer/newsandcovid/fav_news.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        child: ListView(
          children: <Widget>[
            const UserAccountsDrawerHeader(
              accountName: Text('TestName'),
              accountEmail: Text('test@gmail.com'),
              currentAccountPicture: CircleAvatar(),
            ),
            buildMenuItem(
                displayText: 'News',
                icon: Icons.newspaper,
                onClicked: () => routePage(context, 0)),
            const SizedBox(height: 16),
            buildMenuItem(
                displayText: 'Covid Chart',
                icon: Icons.bar_chart_rounded,
                onClicked: () => routePage(context, 1)),
            const SizedBox(height: 16),
            buildMenuItem(
                displayText: 'Favourites',
                icon: Icons.star_border_outlined,
                onClicked: () => routePage(context, 2)),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

Widget buildMenuItem({
  required String displayText,
  required IconData icon,
  VoidCallback? onClicked,
}) {
  return ListTile(
    leading: Icon(
      icon,
      color: Colors.grey,
    ),
    title: Text(
      displayText,
      style: const TextStyle(color: Colors.grey),
    ),
    onTap: onClicked,
  );
}

void routePage(BuildContext context, int index) {
  //Navigator.pop(context);
  switch (index) {
    case 0:
      Navigator.pop(context);
      //Navigator.push(context, MaterialPageRoute(builder: (_) => NewsRoom()));
      break;

    case 1:
      Navigator.push(context, MaterialPageRoute(builder: (_) => CovidChart()));
      break;
    case 2:
      Navigator.push(context, MaterialPageRoute(builder: (_) => FavNews()));
      break;
  }
}
