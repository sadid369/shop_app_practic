import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_practic/provider/cart.dart';

class CartItemWidget extends StatelessWidget {
  final String id;
  final String productKey;
  final double price;
  final int quantity;
  final String title;
  const CartItemWidget({
    Key? key,
    required this.id,
    required this.productKey,
    required this.price,
    required this.quantity,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).errorColor,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(8),
        child: Icon(
          Icons.delete,
          size: 40,
          color: Colors.white,
        ),
      ),
      onDismissed: (value) {
        Provider.of<Cart>(context, listen: false).removeItem(productKey);
      },
      key: ValueKey(id),
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FittedBox(
                fit: BoxFit.cover,
                child: Text(
                  '\$${price}',
                  style: TextStyle(
                      color: Theme.of(context).primaryTextTheme.title!.color),
                ),
              ),
            ),
            backgroundColor: Theme.of(context).primaryColor,
          ),
          title: Text(title),
          subtitle: Text('\$${price * quantity}'),
          trailing: Text('$quantity X'),
        ),
      ),
    );
  }
}
