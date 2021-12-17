import 'package:flutter/material.dart';
import '../models/produto.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  final List<Product> _itens = [
    Product(
      id: 'p1',
      titulo: 'Camiseta Vermelha',
      descricao: 'Uma camisa vermelha - é bem vermelha!',
      preco: 29.99,
      urlDaImagem:
          'https://cea.vtexassets.com/arquivos/ids/10949059-1600-auto?v=637098648287070000&width=1600&height=auto&aspect=true',
    ),
    Product(
      id: 'p2',
      titulo: 'Calças',
      descricao: 'Um par de calças.',
      preco: 59.99,
      urlDaImagem:
          'https://static.netshoes.com.br/produtos/calca-jeans-ecxo-masculina/06/LYU-0332-006/LYU-0332-006_zoom1.jpg?ts=1639474945&',
    ),
    Product(
      id: 'p3',
      titulo: 'Lenço Amarelo',
      descricao:
          'Quente e aconchegane - Exatamente o que você precisa para o inverso.',
      preco: 19.99,
      urlDaImagem:
          'https://m.media-amazon.com/images/I/71s6u5oCKFL._AC_SX385_.jpg',
    ),
    Product(
      id: 'p4',
      titulo: 'Panela',
      descricao: 'Prepare qualquer refeição',
      preco: 49.99,
      urlDaImagem:
          'https://polishop.vtexassets.com/arquivos/ids/670479-1200-auto?v=637473563788800000&width=1200&height=auto&aspect=true',
    ),
  ];

  List<Product> get itens {
    return [..._itens];
  }

  List<Product> get favorites {
    return itens.where((produto) => produto.ehFavorito).toList();
  }

  Product getById(String id) {
    return itens.firstWhere((produto) => produto.id == id);
  }

  void add(Product item) {
    //TODO: Fazer requisição
    final url = Uri.https(
        'flutter-shop-a4b49-default-rtdb.firebaseio.com', '/products.json');

    http
        .post(url,
            body: jsonEncode({
              'title': item.titulo,
              'description': item.descricao,
              'price': item.preco,
              'imageUrl': item.urlDaImagem,
              'isFavorite': item.ehFavorito
            }))
        .then((response) {
      item.id = json.decode(response.body)['name'];
      _itens.add(item);
      //Quando é chamado o notifyListeners
      //Toda a parte do aplicativo que estiver escutando
      //será recarregada chamando o método build do widget
      notifyListeners();
    });
  }

  void update(Product item) {
    //TODO: Fazer requisição
    _itens.remove(item);
    _itens.add(item);
    notifyListeners();
  }

  void delete(String id) {
    //TODO: Fazer requisição
    _itens.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  Product findById(String id) {
    return _itens.firstWhere((element) => element.id == id);
  }
}
