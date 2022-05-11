import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_viewer/login.dart';
import 'package:news_viewer/newsandcovid/covid_chart.dart';
import 'package:news_viewer/newsandcovid/default_home.dart';
import 'package:news_viewer/newsandcovid/fav_news.dart';

var email;
var name;

class DrawerMenu extends StatefulWidget {
  DrawerMenu({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  void initState() {
    getNameandEmail();
    super.initState();
  }

  getNameandEmail() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      var fields = value.data();

      email = fields?['Email'];
      name = fields?['name'];
    });
    print(name);
    print(email);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(
                name.toString(),
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(
                email.toString(),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              currentAccountPicture: CircleAvatar(),
            ),
            buildMenuItem(
                displayText: 'News',
                icon: Icons.newspaper_rounded,
                onClicked: () => routePage(context, 0)),
            const SizedBox(height: 16),
            buildMenuItem(
                displayText: 'Covid Chart',
                icon: Icons.bar_chart_rounded,
                onClicked: () => routePage(context, 1)),
            const SizedBox(height: 16),
            buildMenuItem(
                displayText: 'Favourites',
                icon: Icons.star_border_rounded,
                onClicked: () => routePage(context, 2)),
            const SizedBox(height: 16),
            buildMenuItem(
                displayText: 'Sign Out',
                icon: Icons.logout_rounded,
                onClicked: () => signOut(context))
          ],
        ),
      ),
    );
  }
}

signOut(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute(builder: (_) => LoginPage()), (r) => false);
}

Widget buildMenuItem(
    {required String displayText,
    required IconData icon,
    VoidCallback? onClicked,
    n}) {
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
