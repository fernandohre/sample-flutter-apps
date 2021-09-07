import 'package:aplicativo_loja/providers/carrinho.dart';
import 'package:flutter/cupertino.dart';

class Pedido {
  final String id;
  final double montante;
  final List<ItemDoCarrinho> produtos;
  final DateTime data;

  Pedido({
    @required this.id, 
    @required this.montante, 
    @required this.produtos, 
    @required this.data
  });
}

class Pedidos with ChangeNotifier {
  List<Pedido> _pedidos = [];

  List<Pedido> get pedidos {
    return [..._pedidos];
  }

  void fazerPedido(List<ItemDoCarrinho> pedidos, double total) {
    _pedidos.add(Pedido(
      id: DateTime.now().toString(),
      montante: total,
      data: DateTime.now(),
      produtos: pedidos
    ));
    notifyListeners();
  }
}
