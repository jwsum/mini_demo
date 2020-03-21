import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_counter/flutter_counter.dart';
import 'package:provider/provider.dart';

import 'package:mini_demo/model/product.dart';
import 'package:mini_demo/model/cart.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: _buildBody(context),
    );
  }

  Widget appBar(){
    return AppBar(
      title: Text('Product'),      
      actions: [
        IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () => Navigator.pushNamed(context, '/cart')
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context){
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('Catalog').snapshots(),
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
    final product = Product.fromSnapshot(data);

    return Padding(
      key: ValueKey(product.id),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
         border: Border.all(color: Colors.grey),
         borderRadius: BorderRadius.circular(5.0),
       ),
       child: ListTile(
         title: Text(product.name),
         trailing: Text("RM " + product.price.toString()),
         onTap: () => addProductDialog(context, product)
        ),
     ),
    );
  }

  void addProductDialog(BuildContext context, Product product) {
    var cart = Provider.of<CartModel>(context);
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState){
            return AlertDialog(
              title: new Text('Quantity'),
              content: Counter(
                initialValue: product.quantity,
                minValue: 0,
                maxValue: 10,
                step: 1,
                decimalPlaces: 0,
                onChanged: (value){
                  setState(() {
                    product.quantity = value;
                  });
                },
              ),
              actions: <Widget>[
                FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancel"),
                ),
                FlatButton(
                  onPressed: (){
                    if(product.quantity > 0){
                      cart.add(product);
                    }                    
                    Navigator.pop(context);
                  },
                  child: Text("OK"),
                ),
              ]
            );
          }
        );
      });
  }
}