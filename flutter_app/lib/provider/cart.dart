import 'package:flutter/cupertino.dart';

class CartItem {
  final String? id;
  final String? title;
  final int? quantity;
  final String? content;

  CartItem(
    this.id,
    this.title,
    this.content,
    this.quantity,
  );
}

class Cart with ChangeNotifier {
  final Map<String, CartItem> _cartItems = {};

  Map<String, CartItem> get cartItems => {..._cartItems};
  int get itemCount => _cartItems.length;

  void addCartItem(
    String productId,
    String title,
    String content,
  ) {
    if (_cartItems.containsKey(productId)) {
      // inrease product quantity
      _cartItems.update(
          productId,
          (existingCartItem) => CartItem(
                existingCartItem.id,
                existingCartItem.title,
                existingCartItem.content,
                existingCartItem.quantity! + 1,
              ));
    } else {
      _cartItems.putIfAbsent(
          productId,
          () => CartItem(
                productId,
                title,
                content,
                1,
              ));
    }
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_cartItems.containsKey(productId)) {
      return;
    }
    if (_cartItems[productId]!.quantity! > 1) {
      _cartItems.update(
          productId,
          (existingCartItem) => CartItem(
                existingCartItem.id,
                existingCartItem.title,
                existingCartItem.content,
                existingCartItem.quantity! - 1,
              ));
    } else {
      _cartItems.remove(productId);
    }
    notifyListeners();
  }
}
