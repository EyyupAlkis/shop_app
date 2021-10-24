import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/cart_provider.dart';
import '/providers/products_provider.dart';
import '/views/screens/product_detail_page.dart';
import '/views/screens/products_overview_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => ProductsProvider()),
        ChangeNotifierProvider(create: (ctx) => CartProvider())
      ],
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
            primarySwatch: Colors.purple,
            primaryColor: Colors.deepOrange,
            colorScheme: Theme.of(context)
                .colorScheme
                .copyWith(secondary: Colors.deepOrange),
            fontFamily: 'Lato'),
        initialRoute: ProductsOverviewPage.routeName,
        routes: {
          ProductsOverviewPage.routeName: (ctx) => ProductsOverviewPage(),
          ProductDetailPage.routeName: (ctx) => ProductDetailPage(),
        },
      ),
    );
  }
}
