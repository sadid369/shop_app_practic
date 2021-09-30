import 'package:flutter/material.dart';
import 'package:shop_app_practic/screen/order_screen.dart';
import 'package:shop_app_practic/screen/product_detail_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('your Drawer'),
          ),
          ListTile(
            title: Text('Your Order'),
            onTap: () {
              Navigator.of(context).pushNamed(OrderScreen.routeName);
            },
          ),
          ListTile(
            title: Text('Home'),
            onTap: () {
              Navigator.of(context).pushNamed('/');
            },
          )
        ],
      ),
    );
  }
}
