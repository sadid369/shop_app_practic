import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_practic/provider/cart.dart';
import 'package:shop_app_practic/provider/products.dart';
import 'package:shop_app_practic/screen/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Product>(context, listen: true);
    final cartItem = Provider.of<Cart>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          child: Image.network(
            products.imageUrl,
            fit: BoxFit.cover,
          ),
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                arguments: products.id);
          },
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black38,
          title: Text(products.title),
          leading: IconButton(
            icon: Icon(
                products.isFavorite ? Icons.favorite : Icons.favorite_border),
            onPressed: () {
              products.toggleIsFavorite();
            },
          ),
          trailing: IconButton(
            onPressed: () {
              cartItem.addCartItem(products.id, products.price, products.title);
            },
            icon: Icon(Icons.shopping_cart),
          ),
        ),
      ),
    );
  }
}
