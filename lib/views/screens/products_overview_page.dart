import 'package:flutter/material.dart';

import '/views/widgets/products_grid.dart';

class ProductsOverviewPage extends StatelessWidget {
  static const String routeName = "/product-overview";

  ProductsOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Shop'),
      ),
      body: SafeArea(child: ProductsGrid()),
    );
  }
}
