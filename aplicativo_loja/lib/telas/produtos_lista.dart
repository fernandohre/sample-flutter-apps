import 'package:aplicativo_loja/widgets/app_drawer.dart';

import '../providers/carrinho.dart';
import '../widgets/produto_sacola.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/produtos_grid.dart';
import 'carrinho_tela.dart';

enum OpcoesAppBar {
  ExibirApenasFavoritos,
  ExibirTodos
}

class ListaDeProdutosTela extends StatefulWidget {
  @override
  _ListaDeProdutosTelaState createState() => _ListaDeProdutosTelaState();
}

class _ListaDeProdutosTelaState extends State<ListaDeProdutosTela> {
  var _mostrarApenasFavoritos = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Minha Loja'),
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
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) => [
                PopupMenuItem(child: Text('Exibir Favoritos'), value: OpcoesAppBar.ExibirApenasFavoritos),
                PopupMenuItem(child: Text('Mostrar Todos'), value: OpcoesAppBar.ExibirTodos)
              ],
            ),
            Consumer<Carrinho>(
              builder: (_, dadosDoCarrinho, filhoWidget) =>
              SacolaDeProdutos(
                filho: filhoWidget,
                valor: dadosDoCarrinho.quantidadeDeItens.toString(),
              ),
              child: IconButton(
                icon: Icon(Icons.shopping_cart), 
                onPressed: () {
                  Navigator.of(context).pushNamed(CarrinhoTela.nomeDaRota);
                },
              ),
            )
          ],
        ),
        drawer: AppDrawer(),
        body: ProdutosGrid(_mostrarApenasFavoritos),
      ),
    );
  }
}

