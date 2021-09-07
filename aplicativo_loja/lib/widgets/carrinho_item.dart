import 'package:aplicativo_loja/providers/carrinho.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarrinhoItem extends StatelessWidget {
  final String id;
  final String idDoProduto;
  final double preco;
  final int quantidade;
  final String titulo;

  CarrinhoItem(this.id, this.idDoProduto, this.preco, this.quantidade, this.titulo);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15, 
          vertical: 4
        )
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direcao) {
        Provider.of<Carrinho>(context, listen: false).removerProduto(idDoProduto);
      },
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15, 
          vertical: 4
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: FittedBox(child: Text('R\$$preco')),
            ),
            title: Text(titulo),
            subtitle: Text('Total: R\$${(preco * quantidade)}'),
            trailing: Text('$quantidade x'),
          ),
        ),
      )
    );
  }
}