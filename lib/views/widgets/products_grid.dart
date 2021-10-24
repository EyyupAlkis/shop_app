import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/product_provider.dart';
import '/providers/products_provider.dart';
import '/views/widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool showOnlyFavorites;
  ProductsGrid({Key? key, required this.showOnlyFavorites}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsProvider>(context);
    final productList = showOnlyFavorites
        ? productProvider.favoriteItems
        : productProvider.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: productList.length,
      itemBuilder: (context, index) {
        return ChangeNotifierProvider.value(
          value: ProductProvider(
            product: productList[index],
          ),
          child: ProductItem(
            key: Key(productList[index].id),
          ),
        );
      },
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
    );
  }
}
