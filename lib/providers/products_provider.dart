import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '/models/product.dart';

class ProductsProvider with ChangeNotifier {
  final url =
      'https://shop-app-flutter-53b3f-default-rtdb.europe-west1.firebasedatabase.app/product.json';
  final List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  // var _showFavoritesOnly = false;

  List<Product> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((element) => element.isFavorite).toList();
    // } else {
    //   return [..._items];
    // }
    return [..._items];
  }

  List<Product> get favoriteItems {
    // if (_showFavoritesOnly) {
    //   return _items.where((element) => element.isFavorite).toList();
    // } else {
    //   return [..._items];
    // }
    return _items.where((item) => item.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAllProducts() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  Future<void> addProduct(Product product) async {
    if (_items.any((element) => element.id == product.id)) {
      Product willUpdateProduct = findById(product.id);
      willUpdateProduct.description = product.description;
      willUpdateProduct.title = product.title;
      willUpdateProduct.price = product.price;
      willUpdateProduct.imageUrl = product.imageUrl;
      notifyListeners();
      return Future.value();
    } else {
      return http
          .post(Uri.parse(url),
              body: json.encode({
                'title': product.title,
                'price': product.price,
                'id': product.id,
                'description': product.description,
                'imageUrl': product.imageUrl,
                'isFavorite': product.isFavorite
              }))
          .then((response) {
        final finalProduct = Product(
          id: DateTime.now().toString(),
          title: product.title,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl,
        );
        _items.add(finalProduct);
        notifyListeners();
      }).catchError((error) {
        print(error);
        throw error;
      });
    }
  }

  void deleteProduct(String productId) {
    _items.removeWhere((element) => element.id == productId);
  }

  void _uploadProduct(Product product) async {}
}
