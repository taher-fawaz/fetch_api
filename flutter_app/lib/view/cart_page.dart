import 'package:flutter/material.dart';
import 'package:flutter_app/provider/cart.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  static const routeName = '/CartPage';
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Cart cartItems = Provider.of<Cart>(context);
    final List cartList = cartItems.cartItems.values.toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart Screen"),
      ),
      body: ListView.builder(
        itemCount: cartList.length,
        itemBuilder: (BuildContext context, int i) {
          return ListTile(
            title: Text(cartList[i]!.title!),
            subtitle: Text(cartList[i]!.content!),
            leading: Text(cartList[i]!.quantity!.toString()),
          );
        },
      ),
    );
  }
}
