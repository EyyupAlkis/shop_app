import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/models/filter_options.dart';
import '/providers/cart_provider.dart';
import '/views/widgets/badge.dart';
import '/views/widgets/products_grid.dart';

class ProductsOverviewPage extends StatefulWidget {
  static const String routeName = "/product-overview";

  ProductsOverviewPage({Key? key}) : super(key: key);

  @override
  State<ProductsOverviewPage> createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {
  var _showOnlyFavorites = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Shop'),
        actions: [
          PopupMenuButton(
            itemBuilder: (_) => [
              const PopupMenuItem(
                child: Text("Only Favourites"),
                value: FilterOptions.FAVORITES,
              ),
              const PopupMenuItem(
                child: Text("Show all"),
                value: FilterOptions.ALL,
              )
            ],
            child: const Icon(Icons.more_vert),
            onSelected: (FilterOptions selected) {
              setState(() {
                switch (selected) {
                  case FilterOptions.FAVORITES:
                    _showOnlyFavorites = true;
                    break;
                  case FilterOptions.ALL:
                    _showOnlyFavorites = false;
                    break;
                }
              });
            },
          ),
          Consumer<CartProvider>(
            builder: (context, chartProvider, constChild) => Badge(
              child: constChild!,
              value: chartProvider.itemCount.toString(),
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.shopping_cart,
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: ProductsGrid(showOnlyFavorites: _showOnlyFavorites),
      ),
    );
  }
}
