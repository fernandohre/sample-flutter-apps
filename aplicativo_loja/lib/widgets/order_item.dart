import '../providers/orders.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class OrderItem extends StatefulWidget {
  final Order pedido;
  OrderItem(this.pedido);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('R\$${widget.pedido.montante}'),
            subtitle: Text(DateFormat('dd/MM/yyyy').format(widget.pedido.data)),
            trailing: IconButton(
                icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                }),
          ),
          if (_expanded)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: min(widget.pedido.produtos.length * 20.0 + 10, 100.0),
              child: ListView(
                  children: widget.pedido.produtos
                      .map((p) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                p.titulo,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${p.quantidade} x \$${p.preco}',
                                style:
                                    TextStyle(fontSize: 18, color: Colors.grey),
                              )
                            ],
                          ))
                      .toList()),
            )
        ],
      ),
    );
  }
}
