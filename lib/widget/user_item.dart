import 'package:flutter/material.dart';
import 'package:shop_app_practic/provider/products.dart';
import 'package:shop_app_practic/screen/edit_product_screen.dart';
import 'package:provider/provider.dart';

class UserItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  UserItem({required this.id, required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
          imageUrl,
        ),
      ),
      title: Text(title),
      trailing: Container(
          width: 100,
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(EditProductScreen.routeName, arguments: id);
                  },
                  icon: Icon(Icons.edit)),
              IconButton(
                  onPressed: () {
                    Provider.of<Products>(context, listen: false)
                        .deleteItem(id);
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).errorColor,
                  )),
            ],
          )),
    );
  }
}
