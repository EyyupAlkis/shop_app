import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/cart_provider.dart';
import '/providers/product_provider.dart';
import '/views/screens/product_detail_page.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final product = productProvider.product;
    return GridTile(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(ProductDetailPage.routeName, arguments: product.id);
        },
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(product.imageUrl),
            ),
            border: Border.all(color: Colors.lightBlue.shade100),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
        ),
      ),
      footer: Consumer<ProductProvider>(
        builder: (context, productProvider, child) => GridTileBar(
          backgroundColor: Colors.black87,
          leading: IconButton(
            color: Theme.of(context).primaryColor,
            onPressed: () => productProvider.toggleFavourite(),
            icon: Icon(
              productProvider.product.isFavorite
                  ? Icons.favorite
                  : Icons.favorite_border,
            ),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              cartProvider.addItem(product.id, product.price, product.title);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("${product.title} added to cart!"),
                duration: Duration(seconds: 2),
                action: SnackBarAction(
                  label: 'UNDO',
                  onPressed: () {
                    cartProvider.removeSingleItem(product.id);
                  },
                ),
              ));
            },
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
