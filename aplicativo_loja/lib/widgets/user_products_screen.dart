import 'package:aplicativo_loja/providers/products.dart';
import 'package:aplicativo_loja/widgets/edit_product_screen.dart';
import 'package:aplicativo_loja/widgets/user_product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProductsScreen extends StatelessWidget {
  const UserProductsScreen({key}) : super(key: key);
  static const String routeName = '/user-products';
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Seus produtos'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routeName);
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
            itemCount: productsData.itens.length,
            itemBuilder: (_, i) => UserProductItem(
                  title: productsData.itens[i].titulo,
                  urlImage: productsData.itens[i].urlDaImagem,
                )),
      ),
    );
  }
}
