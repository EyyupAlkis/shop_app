import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  static const String routeName = "/product-detail";
  ProductDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text("title"),
      ),
      body: SafeArea(
        child: Container(),
      ),
    );
  }
}
