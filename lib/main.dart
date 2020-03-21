import 'package:flutter/material.dart';
import 'package:mini_demo/UI/homePage.dart';
import 'package:mini_demo/UI/orderPage.dart';
import 'package:provider/provider.dart';

import 'package:mini_demo/UI/cartPage.dart';
import 'package:mini_demo/UI/loginPage.dart';
import 'package:mini_demo/UI/productPage.dart';
import 'package:mini_demo/model/cart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/':(context) => LoginPage(),
          '/home': (context) => HomePage(authResult: null,),
          '/products': (context) => ProductPage(),
          '/cart': (context) => CartPage(),
          '/orders': (context) => OrderPage(),
        }
      )
    );
  }
}


