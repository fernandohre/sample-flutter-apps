import 'package:aplicativo_loja/providers/carrinho.dart';
import 'package:provider/provider.dart';

import '../models/produto.dart';

import '../telas/produto_detalhes.dart';
import 'package:flutter/material.dart';

class ItemProduto extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final produto = Provider.of<Produto>(context, listen: false);
    final carrinho = Provider.of<Carrinho>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              DetalhesDoProdutoTela.nomeDaRota,
              arguments: produto.id
            );
          },
          child: Image.network(
            produto.urlDaImagem, 
            fit: BoxFit.cover
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Produto>(
            builder: (contexto, produtoAtual, filho) =>
            IconButton(
              icon: Icon(produtoAtual.ehFavorito ? Icons.favorite : Icons.favorite_border),
              onPressed: () {
                produtoAtual.marcarComoFavorito();
              },
              color: Theme.of(context).accentColor
            ),
          ),
          title: Text(
            produto.titulo, 
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart), 
            onPressed: () {
              carrinho.adicionarProduto(
                produto.id, 
                produto.preco, 
                produto.titulo
              );
            },
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}