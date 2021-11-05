import 'package:aplicativo_loja/widgets/app_drawer.dart';
import 'package:aplicativo_loja/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart';

class OrderScreen extends StatelessWidget {
  static const nomeDaRota = '/pedidos';
  @override
  Widget build(BuildContext context) {
    final pedidosProvider = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Seus pedidos'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: pedidosProvider.orders.length,
        itemBuilder: (contexto, indice) =>
            OrderItem(pedidosProvider.orders[indice]),
      ),
    );
  }
}
