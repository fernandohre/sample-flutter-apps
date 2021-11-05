import 'package:aplicativo_loja/providers/cart.dart';
import 'package:flutter/cupertino.dart';

class Order {
  final String id;
  final double montante;
  final List<ItemCart> produtos;
  final DateTime data;

  Order(
      {@required this.id,
      @required this.montante,
      @required this.produtos,
      @required this.data});
}

class Orders with ChangeNotifier {
  List<Order> _ordersList = [];

  List<Order> get orders {
    return [..._ordersList];
  }

  void doOrder(List<ItemCart> pedidos, double total) {
    _ordersList.add(Order(
        id: DateTime.now().toString(),
        montante: total,
        data: DateTime.now(),
        produtos: pedidos));
    notifyListeners();
  }
}
