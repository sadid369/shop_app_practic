import 'package:flutter/material.dart';
import 'package:shop_app_practic/provider/order.dart';
import 'package:shop_app_practic/widget/order_item.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = 'order-screen';

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Order>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Order'),
        ),
        body: ListView.builder(
          itemCount: orderData.orderItems.length,
          itemBuilder: (ctx, i) =>
              OrderItemWidget(order: orderData.orderItems[i]),
        ));
  }
}
