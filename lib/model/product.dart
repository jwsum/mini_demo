import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final int id;
  final String name;
  final String type;
  final num price;
  final DocumentReference reference;
  int quantity = 0;
  
  num get totalPrice => quantity * price;
  
  Product.fromMap(Map<String, dynamic> map, {this.reference})
    : assert(map['id'] != null),
      assert(map['name'] != null),
      assert(map['type'] != null),
      assert(map['price'] != null),
      id = map['id'],
      name = map['name'],
      type = map['type'],
      price = map['price'];

  Product.fromSnapshot(DocumentSnapshot snapshot)
    : this.fromMap(snapshot.data, reference: snapshot.reference);

}