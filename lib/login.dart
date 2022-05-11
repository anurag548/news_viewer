import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_viewer/newsandcovid/default_home.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  // Controllers
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  //Registration
  bool isRegstered = false;

  //Login Form Widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    const CircleAvatar(
                      maxRadius: 90.0,
                      backgroundImage: AssetImage("images/logo.png"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    isRegstered
                        ? TextFormField(
                            keyboardType: TextInputType.name,
                            controller: _nameController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                label: const Text('Name'),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.auto),
                          )
                        : const SizedBox(),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
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
                      keyboardType: TextInputType.visiblePassword,
                      autocorrect: false,
                      obscureText: true,
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
                    isRegstered
                        ? ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.black)),
                            onPressed: _registerUser,
                            child: const Text('Register'))
                        : ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.black)),
                            onPressed: _loginUser,
                            child: const Text('Login'))
                  ]),
            )),
      ),
    );
  }

  Future<void> _registerUser() async {
    try {
      await _auth
          .createUserWithEmailAndPassword(
              email: _usernameController.text,
              password: _passwordController.text)
          .then((value) => {
                FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: _usernameController.text,
                    password: _passwordController.text)
              });
      var user = _auth.currentUser!.uid;
      var createDB = _db.collection('users').doc(user);
      var dataToUpload = {
        'name': _nameController.text,
        'Email': _usernameController.text,
        'Password': _passwordController.text,
      };
      await createDB.set(dataToUpload);
    } catch (e) {}
  }

  Future<void> _loginUser() async {
    try {
      await _auth
          .signInWithEmailAndPassword(
              email: _usernameController.text,
              password: _passwordController.text)
          .then((value) => Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (_) => NewsRoom()), (r) => false));
    } on FirebaseAuthException catch (e) {
      print(e);
      if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: "Wrong Password");
      }
      if (e.code == 'invalid-email') {
        Fluttertoast.showToast(msg: "Invalid Email");
      }
      if (e.code == "user-not-found") {
        setState(() {
          isRegstered = true;
        });
        Fluttertoast.showToast(msg: "No such Email");
      }
    }
  }
}
