import 'package:aplicativo_loja/providers/orders.dart';

import '../widgets/cart_item.dart';

import '../providers/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/carrinho';

  const CartScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final carrinho = Provider.of<Cart>(context);

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
                    Text(
                      'Total:',
                      style: TextStyle(fontSize: 20),
                    ),
                    Spacer(),
                    Chip(
                      label: Text(
                        'R\$${carrinho.precoTotalDosItens}',
                        style: TextStyle(
                            color: Theme.of(context)
                                .primaryTextTheme
                                .button
                                .color),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    TextButton(
                      child: Text(
                        'Buy Now!',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                      onPressed: () {
                        Provider.of<Orders>(context, listen: false).doOrder(
                            carrinho.itens.values.toList(),
                            carrinho.precoTotalDosItens);
                        carrinho.clear();
                      },
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: ListView.builder(
              itemBuilder: (contexto, indice) => CartItem(
                  carrinho.itens.values.toList()[indice].id,
                  carrinho.itens.keys.toList()[indice],
                  carrinho.itens.values.toList()[indice].preco,
                  carrinho.itens.values.toList()[indice].quantidade,
                  carrinho.itens.values.toList()[indice].titulo),
              itemCount: carrinho.itens.length,
            ))
          ],
        ));
  }
}
