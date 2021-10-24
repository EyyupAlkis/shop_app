import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';
import '/models/product.dart';
import '/views/widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {
  ProductsGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsProvider>(context);
    final productList = productProvider.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: productList.length,
      itemBuilder: (context, index) {
        return ProductItem(product: productList[index]);
      },
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
    );
  }
}
