import 'package:aplicativo_loja/providers/pedidos.dart';

import '../widgets/carrinho_item.dart';

import '../providers/carrinho.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarrinhoTela extends StatelessWidget {

  static const nomeDaRota = '/carrinho';

  const CarrinhoTela({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final carrinho = Provider.of<Carrinho>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho de compras'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Total:', style: TextStyle(fontSize: 20),),
                  Spacer(),
                  Chip(
                    label: Text(
                      'R\$${carrinho.precoTotalDosItens}', 
                      style: TextStyle(color: Theme.of(context).primaryTextTheme.title.color),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(
                    child: Text('Comprar agora!', style: TextStyle(color: Theme.of(context).primaryColor),),
                    onPressed: () {
                      Provider.of<Pedidos>(context, listen: false).fazerPedido(
                        carrinho.itens.values.toList(), 
                        carrinho.precoTotalDosItens
                      );
                      carrinho.limparCarrinho();
                    },
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
          Expanded(
            child: ListView.builder(
              itemBuilder: (contexto, indice) => CarrinhoItem(
                carrinho.itens.values.toList()[indice].id, 
                carrinho.itens.keys.toList()[indice],
                carrinho.itens.values.toList()[indice].preco, 
                carrinho.itens.values.toList()[indice].quantidade, 
                carrinho.itens.values.toList()[indice].titulo
              ), 
              itemCount: carrinho.itens.length,
            )
          )
        ],
      )
    );
  }
}