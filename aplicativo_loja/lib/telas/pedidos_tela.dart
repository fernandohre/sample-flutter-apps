import 'package:aplicativo_loja/widgets/app_drawer.dart';
import 'package:aplicativo_loja/widgets/pedido_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/pedidos.dart';
class PedidosTela extends StatelessWidget {
  static const nomeDaRota = '/pedidos';
  @override
  Widget build(BuildContext context) {
    final pedidosProvider = Provider.of<Pedidos>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Seus pedidos'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: pedidosProvider.pedidos.length,
        itemBuilder: (contexto, indice) => PedidoItem(pedidosProvider.pedidos[indice]),
      ),
    );
  }
}