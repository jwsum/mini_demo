import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import "package:mini_demo/model/order.dart";

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("Orders")),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context){
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('Order').snapshots(),
      builder: (context, snapshot){
        if(!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot){
    return ListView(
      padding: const EdgeInsets.only(top: 20),
      children: snapshot.map((data) => _buildListItem(context, data)).toList()
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data){
    final order = Order.fromSnapshot(data);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
         border: Border.all(color: Colors.grey),
         borderRadius: BorderRadius.circular(5.0),
       ),
       child: ListTile(
         title: Text("Order at " + order.timestamp.toString()),
         trailing: Text("RM " + order.totalPrice.toString()),
         onTap: () => showContent(context, order.cartList),
        ),
     ),
    );
  }

  void showContent(BuildContext context,  List<dynamic> list) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState){
            return AlertDialog(
              title: new Text('Order details'),
              content: _buildSubList(context, list)
            );
          }
        );
      });
  }

  Widget _buildSubList(BuildContext context, List<dynamic> list){
    List<Widget> widgetList = [];
    for(var item in list){
      widgetList.add(ListTile(
        leading: Text(item['quantity'].toString() + " x"),
        title: Text(item['name']),
        trailing: Text("RM " + item['price'].toString()),
      ));
    }
    return ListView(
      children: widgetList
    );
  }
}