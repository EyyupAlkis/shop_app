import 'package:flutter/material.dart';

import '/models/cart.dart';

class CartProvider with ChangeNotifier {
  Map<String, Cart> _items = {};

  Map<String, Cart> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      //change quantity
      _items.update(
          productId,
          (existingCard) => Cart(
                id: existingCard.id,
                title: existingCard.title,
                price: existingCard.price,
                quantity: existingCard.quantity + 1,
              ));
    } else {
      _items.putIfAbsent(
        productId,
        () => Cart(
            id: DateTime.now().toString(),
            title: title,
            price: price,
            quantity: 1),
      );
    }
    notifyListeners();
  }
}
