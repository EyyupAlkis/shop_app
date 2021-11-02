import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/products_provider.dart';
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
        title: Text('Your Products'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
            itemCount: productProvider.items.length,
            itemBuilder: (builderContex, index) {
              return Column(
                children: [
                  UserProductItem(
                    title: productProvider.items[index].title,
                    imageUrl: productProvider.items[index].imageUrl,
                  ),
                  const Divider()
                ],
              );
            }),
      ),
    );
  }
}
