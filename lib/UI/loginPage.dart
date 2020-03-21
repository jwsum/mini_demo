import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mini_demo/UI/homePage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return test();
  }

  Widget test() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              validator: (input) {
                if (input.isEmpty) {
                  return 'Email cannot be empty';
                }
              },
              onSaved: (input) => _email = input,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              validator: (input) {
                if (input.length < 6) {
                  return 'Password must be at least 6 characters';
                }
              },
              onSaved: (input) => _password = input,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            RaisedButton(
              onPressed: signIn,
              child: Text('Sign In'),
            )
          ],
        ),
      ),
    );
  }

  Future<void> signIn() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        AuthResult authResult = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.of(context).pushReplacement(new MaterialPageRoute(
            settings: const RouteSettings(name: '/home'),
            builder: (context) => new HomePage(
                  authResult: authResult,
                )));
      }on PlatformException catch (e) {
        print(e);
        alertDialog(dimissable: true, title: "Message", message: "${e.message}" );
      }
    }
  }

  void alertDialog({bool dimissable, String title, String message}){
    showDialog(
      barrierDismissible: dimissable,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: new Text('$title'),
          content: new Text('$message'),
          actions: <Widget>[
            FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("OK"),
                ),
          ],
        );
      });
  }
}