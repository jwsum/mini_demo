import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';


import 'package:mini_demo/UI/orderPage.dart';
import 'package:mini_demo/UI/productPage.dart';


class HomePage extends StatefulWidget {
  HomePage({Key key, @required this.authResult}) : super (key : key);
  final AuthResult authResult;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void viewProduct(){
    Navigator.of(context).push(new MaterialPageRoute(
      settings: const RouteSettings(name: '/product'),
      builder: (context) => new ProductPage()));
  }

  void viewOrder(){
    Navigator.of(context).push(new MaterialPageRoute(
      settings: const RouteSettings(name: '/order'),
      builder: (context) => new OrderPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title : Text("Hi ${widget.authResult.user.email}")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                onPressed: viewProduct,
                child: Text("View Product"),
              ),
              RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                onPressed: viewOrder,
                child: Text("View Order"),
              )
            ]
          ),
        ),
      );
  }
}