import 'package:flutter/foundation.dart';
import 'package:mini_demo/model/order.dart';
import 'package:mini_demo/model/product.dart';

class CartModel extends ChangeNotifier {
  final List<Product> _productList = [];
  Product _product;
  Order _order;
  
  Product get product => _product;
  Order get order => _order;

  List<Product> get products => _productList;

  int get totalPrice =>
      products.fold(0, (total, current) => total + current.totalPrice);

  void add(Product product) {
    _productList.add(product);
    notifyListeners();
  }

  void remove(int index){
    _productList.removeAt(index);
    notifyListeners();
  }

  void clearCart(){
    _productList.clear();
    notifyListeners();
  }
}