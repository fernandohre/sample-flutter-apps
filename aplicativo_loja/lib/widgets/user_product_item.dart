import 'package:aplicativo_loja/providers/products.dart';
import 'package:aplicativo_loja/widgets/edit_product_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String urlImage;

  UserProductItem({this.id, this.title, this.urlImage});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(this.title),
      leading: CircleAvatar(backgroundImage: NetworkImage(this.urlImage)),
      trailing: Container(
          width: 100,
          child: Row(children: [
            IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(EditProductScreen.routeName, arguments: id);
                },
                icon: Icon(Icons.edit),
                color: Theme.of(context).primaryColor),
            IconButton(
              onPressed: () {
                Provider.of<Products>(context, listen: false).delete(id);
              },
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
            )
          ])),
    );
  }
}
