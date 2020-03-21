import 'package:flutter/material.dart';
import 'package:mini_demo/model/cart.dart';
import 'package:mini_demo/model/order.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart')
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: _CartList(),
              ),
            ),
            Center(
              child: RaisedButton(
                onPressed: (){
                  cart.clearCart();
                },
                child: Text("Clear Cart")
                ,),),
            Divider(height: 4, color: Colors.black),
            _CartTotal()
          ],
        ),
      ),
    );
  }
}

class _CartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var itemNameStyle = Theme.of(context).textTheme.title;
    var cart = Provider.of<CartModel>(context);

    return ListView.builder(
      itemCount: cart.products.length,
      itemBuilder: (context, index) => ListTile(
        dense: true,
        leading: Text(cart.products[index].quantity.toString() + " x"),
        title: Text(
          cart.products[index].name,
          style: itemNameStyle,
        ),
        subtitle: Text(" Price: RM" + cart.products[index].totalPrice.toString()),
        trailing: RaisedButton(
          onPressed: (){
            cart.remove(index);
          },
          child: Text("X"),
        ),
      ),
    );
  }
}

class _CartTotal extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    var hugeStyle = Theme.of(context).textTheme.display4.copyWith(fontSize: 48);
    var cart = Provider.of<CartModel>(context);
    final Order order = new Order(cart.totalPrice, DateTime.now());

    return SizedBox(
      height: 200,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<CartModel>(
                builder: (context, cart, child) =>
                    Text('\$${cart.totalPrice}', style: hugeStyle)),
            SizedBox(width: 24),
            FlatButton(
              onPressed: () {
                if(cart.products.length > 0){
                  order.createRecord(cart.products);
                  Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text('Your Order has been placed.')));
                  cart.clearCart();
                }else{
                  Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text('No item in the cart')));
                }
              },
              color: Colors.white,
              child: Text('Place Order'),
            ),
          ],
        ),
      ),
    );
  }
}