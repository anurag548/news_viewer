import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:news_viewer/newsandcovid/default_home.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;
  // Controllers

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  //Login Form Widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      label: const Text('Email'),
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
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black)),
                    onPressed: _loginUser,
                    child: const Text('Login'))
              ])),
    );
  }

  Future<void> _loginUser() async {
    try {
      final login = await _auth.signInWithEmailAndPassword(
          email: _usernameController.text, password: _passwordController.text);
      if (login != null) {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_) => NewsRoom()), (r) => false);
      }
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}
