import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/order_provider.dart';
import '/views/widgets/order_item.dart';

class OrderPage extends StatelessWidget {
  static const routeName = "/order";
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      body: ListView.builder(
        itemCount: orderProvider.orders.length,
        itemBuilder: (context, index) {
          return OrderItem(
            order: orderProvider.orders[index],
          );
        },
      ),
    );
  }
}
