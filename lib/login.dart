import 'package:flutter/material.dart';
import 'package:news_viewer/newsandcovid/default_home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controllers

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  //Login Form Widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
              Widget>[
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  label: const Text('Username'),
                  floatingLabelBehavior: FloatingLabelBehavior.auto),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  label: const Text('Password'),
                  floatingLabelBehavior: FloatingLabelBehavior.auto),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black)),
                onPressed: () => {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const NewsRoom()))
                    },
                child: Text('Change Page'))
          ])),
    );
  }
}
