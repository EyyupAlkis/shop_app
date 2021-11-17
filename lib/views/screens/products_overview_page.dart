import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/views/widgets/app_drawer.dart';

import '/models/filter_options.dart';
import '/providers/cart_provider.dart';
import '/views/widgets/badge.dart';
import '/views/widgets/products_grid.dart';
import 'cart_page.dart';

class ProductsOverviewPage extends StatefulWidget {
  static const String routeName = "/product-overview";

  ProductsOverviewPage({Key? key}) : super(key: key);

  @override
  State<ProductsOverviewPage> createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {
  var _showOnlyFavorites = false;
  var _isInit = false;
  var _isLoading = false;

  @override
  void initState() {
    //Provider.of<ProductsProvider>(context, listen: false).fetchAndSetProducts();
    // Future.delayed(Duration.zero).then((_) => {
    //       Provider.of<ProductsProvider>(context, listen: false)
    //           .fetchAndSetProducts()
    //     });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProductsProvider>(context, listen: false)
          .fetchAndSetProducts()
          .then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = true;
    super.didChangeDependencies();
  }

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
              onPressed: () =>
                  Navigator.of(context).pushNamed(CartPage.routeName),
              icon: const Icon(
                Icons.shopping_cart,
              ),
            ),
          )
        ],
      ),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ProductsGrid(showOnlyFavorites: _showOnlyFavorites),
      ),
    );
  }
}
