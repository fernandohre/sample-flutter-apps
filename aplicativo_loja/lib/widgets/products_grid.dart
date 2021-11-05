import '../providers/products.dart';
import 'product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {
  final bool showOnlyFavorites;

  ProductsGrid(this.showOnlyFavorites);

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Products>(context);
    final list = showOnlyFavorites ? data.favorites : data.itens;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemBuilder: (contexto, indice) => ChangeNotifierProvider.value(
        value: list[indice],
        child: ProductItem(),
      ),
      itemCount: list.length,
    );
  }
}
