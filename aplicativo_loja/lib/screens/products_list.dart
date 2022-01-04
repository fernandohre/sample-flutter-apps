import 'package:aplicativo_loja/providers/products.dart';
import 'package:aplicativo_loja/widgets/app_drawer.dart';

import '../providers/cart.dart';
import '../widgets/product_bag.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/products_grid.dart';
import 'cart_screen.dart';

enum OpcoesAppBar { ExibirApenasFavoritos, ExibirTodos }

class ListaDeProdutosTela extends StatefulWidget {
  @override
  _ListaDeProdutosTelaState createState() => _ListaDeProdutosTelaState();
}

class _ListaDeProdutosTelaState extends State<ListaDeProdutosTela> {
  var _mostrarApenasFavoritos = false;
  var isInit = true;
  var isLoading = true;
  @override
  void didChangeDependencies() {
    if (isInit) {
      Provider.of<Products>(context)
          .fetchAndSetProducts()
          .then((value) => setState(() {
                isLoading = false;
              }));
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Loja'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (OpcoesAppBar valorSelecionado) {
              setState(() {
                if (valorSelecionado == OpcoesAppBar.ExibirApenasFavoritos) {
                  _mostrarApenasFavoritos = true;
                } else {
                  _mostrarApenasFavoritos = false;
                }
              });
            },
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => [
              const PopupMenuItem(
                  child: Text('Exibir Favoritos'),
                  value: OpcoesAppBar.ExibirApenasFavoritos),
              const PopupMenuItem(
                  child: Text('Mostrar Todos'), value: OpcoesAppBar.ExibirTodos)
            ],
          ),
          Consumer<Cart>(
            builder: (_, dadosDoCarrinho, filhoWidget) => SacolaDeProdutos(
              filho: filhoWidget,
              valor: dadosDoCarrinho.quantidadeDeItens.toString(),
            ),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGrid(_mostrarApenasFavoritos),
    );
  }
}
