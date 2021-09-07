import './telas/pedidos_tela.dart';

import './telas/carrinho_tela.dart';
import './providers/carrinho.dart';
import 'package:flutter/material.dart';
import 'providers/pedidos.dart';
import 'telas/produtos_lista.dart';
import './telas/produto_detalhes.dart';
import './providers/produtos.dart';
import 'package:provider/provider.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Produtos(),
        ),
        ChangeNotifierProvider.value(
          value: Carrinho()
        ),
        ChangeNotifierProvider.value(
          value: Pedidos()
        )
      ],
      child: MaterialApp(
        title: 'Flutter Loja Virtual',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        home: ListaDeProdutosTela(),
        routes: {
          DetalhesDoProdutoTela.nomeDaRota: (contexto) => DetalhesDoProdutoTela(),
          CarrinhoTela.nomeDaRota: (contexto) => CarrinhoTela(),
          PedidosTela.nomeDaRota: (contexto) => PedidosTela()
        },
      ),
    );
  }
}

