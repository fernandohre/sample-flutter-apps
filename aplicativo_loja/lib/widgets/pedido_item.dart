import '../providers/pedidos.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PedidoItem extends StatelessWidget {
  final Pedido pedido;
  PedidoItem(this.pedido); 
  @override 
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('R\$${pedido.montante}'),
            subtitle: Text(DateFormat('dd/MM/yyyy').format(pedido.data)),
            trailing: IconButton(
              icon: Icon(Icons.expand_more), 
              onPressed: null
            ),
          )
        ],
      ),
    );
  }
}