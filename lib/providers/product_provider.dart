import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '/models/product.dart';

class ProductProvider with ChangeNotifier {
  final Product product;
  ProductProvider({required this.product});

  Future<void> toggleFavourite() async {
    final oldStatus = product.isFavorite;
    product.isFavorite = !product.isFavorite;
    notifyListeners();
    final updateUrl =
        'https://shop-app-flutter-53b3f-default-rtdb.europe-west1.firebasedatabase.app/product/${product.id}.json';
    try {
      await http.patch(Uri.parse(updateUrl),
          body: json.encode({'isFavorite': product.isFavorite}));
    } on Exception catch (e) {
      product.isFavorite = oldStatus;
      notifyListeners();
    }
  }
}
