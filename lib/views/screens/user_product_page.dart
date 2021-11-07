import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/products_provider.dart';
import '/views/screens/edit_product_page.dart';
import '/views/widgets/app_drawer.dart';
import '/views/widgets/user_product_item.dart';

class UserProductPage extends StatelessWidget {
  static const routeName = "/userProduct";
  const UserProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsProvider>(context);
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductPage.routeName);
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: productProvider.items.length,
          itemBuilder: (builderContex, index) {
            return Column(
              children: [
                UserProductItem(
                  id: productProvider.items[index].id,
                  title: productProvider.items[index].title,
                  imageUrl: productProvider.items[index].imageUrl,
                ),
                const Divider()
              ],
            );
          },
        ),
      ),
    );
  }
}
