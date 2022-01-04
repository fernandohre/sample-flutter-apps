import 'dart:convert';

import 'package:aplicativo_loja/providers/cart.dart';
import 'package:aplicativo_loja/widgets/cart_item.dart';
import 'package:aplicativo_loja/widgets/order_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

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

  Future<void> fetchAndSetOrders() async {
    final url = Uri.https(
        'flutter-shop-a4b49-default-rtdb.firebaseio.com', '/orders.json');
    final response = await http.get(url);
    final List<Order> loadedOrders = [];
    final extractedData = jsonDecode(response.body) as Map<String, dynamic>;
    extractedData.forEach((id, data) {
      loadedOrders.add(Order(
          id: id,
          montante: data['amount'],
          data: DateTime.parse(data['datetime']),
          produtos: (data['products'] as List<dynamic>)
              .map((e) => ItemCart(
                  id: e['id'],
                  titulo: e['title'],
                  quantidade: e['quantity'],
                  preco: e['price']))
              .toList()));
    });
    _ordersList = loadedOrders;
    notifyListeners();
    print(response);
  }

  Future<void> doOrder(List<ItemCart> pedidos, double total) async {
    final url = Uri.https(
        'flutter-shop-a4b49-default-rtdb.firebaseio.com', '/orders.json');
    final timestamp = DateTime.now();
    final response = await http.post(url,
        body: jsonEncode({
          'amount': total,
          'datetime': timestamp.toIso8601String(),
          'products': pedidos
              .map((e) => {
                    'id': e.id,
                    'title': e.titulo,
                    'quantity': e.quantidade,
                    'price': e.preco
                  })
              .toList()
        }));
    _ordersList.add(Order(
        id: jsonDecode(response.body)['name'],
        montante: total,
        data: DateTime.now(),
        produtos: pedidos));
    notifyListeners();
  }
}
