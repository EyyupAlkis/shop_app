import 'package:flutter/material.dart';

import '/models/product.dart';

class ProductProvider with ChangeNotifier {
  final Product product;
  ProductProvider({required this.product});

  void toggleFavourite() {
    product.isFavorite = !product.isFavorite;
    notifyListeners();
  }
}
