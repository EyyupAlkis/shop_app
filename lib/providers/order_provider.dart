import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '/models/cart.dart';
import '/models/order.dart';

class OrderProvider with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders {
    return List.from(_orders);
  }

  void addOrder(List<Cart> cartProducts, double total) {
    _orders.add(
      Order(
        id: DateTime.now().toString(),
        amount: total,
        products: cartProducts,
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  void clear() {
    _orders = [];
    notifyListeners();
  }
}
