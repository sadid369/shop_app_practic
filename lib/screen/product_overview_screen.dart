import 'package:flutter/material.dart';
import 'package:shop_app_practic/provider/cart.dart';
import 'package:shop_app_practic/screen/cart_screen.dart';
import 'package:shop_app_practic/widget/app_drawer.dart';
import 'package:shop_app_practic/widget/badge.dart';
import 'package:shop_app_practic/widget/product_grid.dart';
import 'package:provider/provider.dart';

enum FilterOption { Favorites, All }

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showOnlyFavorite = false;
  @override
  Widget build(BuildContext context) {
    final cartItem = Provider.of<Cart>(context);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('MySho5'),
        actions: [
          PopupMenuButton(
              onSelected: (FilterOption selecetedValue) {
                setState(() {
                  if (selecetedValue == FilterOption.Favorites) {
                    _showOnlyFavorite = true;
                  } else {
                    _showOnlyFavorite = false;
                  }
                });
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) => [
                    PopupMenuItem(
                      child: Text('Favorites'),
                      value: FilterOption.Favorites,
                    ),
                    PopupMenuItem(
                      child: Text('Show All'),
                      value: FilterOption.All,
                    ),
                  ]),
          Badge(
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
                icon: Icon(Icons.shopping_cart),
              ),
              title: cartItem.itemCount.toString())
        ],
      ),
      body: ProductGrid(
        showFavorite: _showOnlyFavorite,
      ),
    );
  }
}
