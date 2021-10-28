import 'package:flutter/material.dart';
import 'package:shop_app_practic/provider/cart.dart';
import 'package:shop_app_practic/provider/order.dart';
import 'package:shop_app_practic/provider/products.dart';
import 'package:shop_app_practic/screen/cart_screen.dart';
import 'package:shop_app_practic/screen/edit_product_screen.dart';
import 'package:shop_app_practic/screen/order_screen.dart';
import 'package:shop_app_practic/screen/product_detail_screen.dart';
import 'package:shop_app_practic/screen/product_overview_screen.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_practic/screen/user_product_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Order(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shop App',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
        ),
        routes: {
          '/': (ctx) => ProductOverviewScreen(),
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrderScreen.routeName: (ctx) => OrderScreen(),
          UserProductScreen.routeName: (ctx) => UserProductScreen(),
          EditProductScreen.routeName: (ctx) => EditProductScreen(),
        },
      ),
    );
  }
}
