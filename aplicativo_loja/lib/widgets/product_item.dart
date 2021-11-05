import 'package:aplicativo_loja/providers/cart.dart';
import 'package:aplicativo_loja/providers/products.dart';
import 'package:provider/provider.dart';

import '../models/produto.dart';

import '../telas/product_detail.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailsScreen.nomeDaRota,
                arguments: product.id);
          },
          child: Image.network(product.urlDaImagem, fit: BoxFit.cover),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder: (contexto, produtoAtual, filho) => IconButton(
                icon: Icon(produtoAtual.ehFavorito
                    ? Icons.favorite
                    : Icons.favorite_border),
                onPressed: () {
                  produtoAtual.marcarComoFavorito();
                },
                color: Theme.of(context).secondaryHeaderColor),
          ),
          title: Text(
            'Little test',
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              cart.add(product.id, product.preco, product.titulo);
              //show snackbar here
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Added Item ${product.titulo} to cart'),
                duration: Duration(seconds: 2),
                action: SnackBarAction(
                  label: 'Undo',
                  onPressed: () {
                    cart.removeSingleItem(product.id);
                  },
                ),
              ));
            },
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}
