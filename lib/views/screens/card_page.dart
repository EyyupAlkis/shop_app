// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/cart_provider.dart';
import '/views/widgets/cart_item.dart';

class CartPage extends StatelessWidget {
  static const String routeName = "/cart";
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: TextStyle(fontSize: 20),
                ),
                Spacer(),
                Chip(
                  label: Text(
                    '${cartProvider.totalAmount}\$',
                    style: TextStyle(
                        color: Theme.of(context)
                                .primaryTextTheme
                                .headline6!
                                .color ??
                            Colors.white),
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Order Now',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: cartProvider.itemCount,
              itemBuilder: (context, index) {
                return CartItem(
                    id: cartProvider.items.values.toList()[index].id,
                    productId: cartProvider.items.keys.toList()[index],
                    price: cartProvider.items.values.toList()[index].price,
                    quantity:
                        cartProvider.items.values.toList()[index].quantity,
                    title: cartProvider.items.values.toList()[index].title);
              },
            ),
          ),
        ],
      ),
    );
  }
}
