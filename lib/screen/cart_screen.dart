import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_practic/provider/cart.dart';
import 'package:shop_app_practic/provider/order.dart';
import 'package:shop_app_practic/widget/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = 'cart-screen';

  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<Cart>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Cart'),
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total:',
                        style: TextStyle(fontSize: 20),
                      ),
                      Chip(
                        label: Text(
                          cartData.itemTotal.toString(),
                          style: TextStyle(
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .title!
                                  .color),
                        ),
                        backgroundColor: Theme.of(context).primaryColor,
                        elevation: 15,
                        shadowColor: Theme.of(context).accentColor,
                      ),
                      FlatButton(
                        onPressed: () {
                          Provider.of<Order>(context, listen: false).addItems(
                              cartData.cartItems.values.toList(),
                              cartData.itemTotal);
                          cartData.clear();
                        },
                        child: Text(
                          'Order Now',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: cartData.itemCount,
                  itemBuilder: (ctx, i) => CartItemWidget(
                        id: cartData.cartItems.values.toList()[i].id,
                        productKey: cartData.cartItems.keys.toList()[i],
                        price: cartData.cartItems.values.toList()[i].price,
                        quantity:
                            cartData.cartItems.values.toList()[i].quantity,
                        title: cartData.cartItems.values.toList()[i].title,
                      )),
            ),
          ],
        ));
  }
}
