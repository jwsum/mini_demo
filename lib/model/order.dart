import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mini_demo/model/product.dart';

class Order{
  final databaseRef = Firestore.instance;
  final List<dynamic> cartList;
  final num totalPrice;
  final DateTime timestamp;
  final DocumentReference reference;

  Order(this.totalPrice, this.timestamp, {this.reference, this.cartList});

  Order.fromMap(Map<String, dynamic> map, {this.reference})
    : assert(map['cart'] != null),
      assert(map['totalPrice'] != null),
      assert(map['timestamp'] != null),
      cartList = map['cart'],
      totalPrice = map['totalPrice'],
      timestamp = (map['timestamp'] as Timestamp).toDate();

  Order.fromSnapshot(DocumentSnapshot snapshot)
    : this.fromMap(snapshot.data, reference: snapshot.reference);

  void createRecord(List<Product> products) async{

    await databaseRef.collection("Order").add({
      'cart' : getMapList(products),
      'totalPrice' : totalPrice,
      'timestamp' : timestamp
    });
  }

  List<Map<String, dynamic>> getMapList(List<Product> products) {
    final List<Map<String,dynamic>> _productListJson = [];
    for(Product p in products){
      final Map<String, dynamic> pData = new Map<String, dynamic>();
      pData["name"] = p.name;
      pData["price"] = p.price;
      pData["quantity"] = p.quantity;
      _productListJson.add(pData);
    }
    return _productListJson;
  }
}