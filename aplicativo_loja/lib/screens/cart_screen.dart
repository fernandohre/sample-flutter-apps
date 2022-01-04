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
          title: const Text('Carrinho de compras'),
        ),
        body: Column(
          children: <Widget>[
            Card(
              margin: const EdgeInsets.all(15),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      'Total:',
                      style: TextStyle(fontSize: 20),
                    ),
                    const Spacer(),
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
                    OrderButton(carrinho: carrinho)
                  ],
                ),
              ),
            ),
            const SizedBox(
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

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.carrinho,
  }) : super(key: key);

  final Cart carrinho;

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: isLoading
          ? const CircularProgressIndicator()
          : Text(
              'Buy Now!',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
      onPressed: widget.carrinho.quantidadeDeItens <= 0
          ? null
          : () async {
              setState(() {
                isLoading = true;
              });
              await Provider.of<Orders>(context, listen: false).doOrder(
                  widget.carrinho.itens.values.toList(),
                  widget.carrinho.precoTotalDosItens);
              widget.carrinho.clear();
            },
    );
  }
}
