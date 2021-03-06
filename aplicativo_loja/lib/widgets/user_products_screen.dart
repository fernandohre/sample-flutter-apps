import 'package:aplicativo_loja/providers/products.dart';
import 'package:aplicativo_loja/widgets/edit_product_screen.dart';
import 'package:aplicativo_loja/widgets/user_product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProductsScreen extends StatelessWidget {
  const UserProductsScreen({key}) : super(key: key);
  static const String routeName = '/user-products';

  Future<void> _fetchProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchAndSetProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Seus produtos'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(EditProductScreen.routeName);
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: RefreshIndicator(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: ListView.builder(
                itemCount: productsData.itens.length,
                itemBuilder: (_, i) => UserProductItem(
                      id: productsData.itens[i].id,
                      title: productsData.itens[i].titulo,
                      urlImage: productsData.itens[i].urlDaImagem,
                    )),
          ),
          onRefresh: () => _fetchProducts(context),
        ));
  }
}
