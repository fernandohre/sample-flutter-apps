import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserProductItem extends StatelessWidget {
  final String title;
  final String urlImage;

  UserProductItem({this.title, this.urlImage});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(this.title),
      leading: CircleAvatar(backgroundImage: NetworkImage(this.urlImage)),
      trailing: Container(
          width: 100,
          child: Row(children: [
            IconButton(
                onPressed: () {},
                icon: Icon(Icons.edit),
                color: Theme.of(context).primaryColor),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
            )
          ])),
    );
  }
}
