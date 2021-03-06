import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/cart_provider.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  const CartItem({
    Key? key,
    required this.id,
    required this.productId,
    required this.price,
    required this.quantity,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) => showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('Are you sure?'),
                content: const Text(
                  'Do you want to remove the item from the cart?',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(ctx).pop(false),
                    child: const Text('NO'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(ctx).pop(true),
                    child: const Text('YES'),
                  )
                ],
              )),
      onDismissed: (DismissDirection dismissDirection) {
        Provider.of<CartProvider>(context, listen: false).removeItem(productId);
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 16),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        color: Theme.of(context).errorColor,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 28,
        ),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: FittedBox(child: Text('${price}\$')),
            ),
            title: Text(title),
            subtitle: Text('Total ${price * quantity}\$'),
            trailing: Text('${quantity} x'),
          ),
        ),
      ),
    );
  }
}
