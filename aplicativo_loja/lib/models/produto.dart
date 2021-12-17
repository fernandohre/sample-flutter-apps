import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  String id;
  final String titulo;
  final String descricao;
  final double preco;
  final String urlDaImagem;
  bool ehFavorito;

  Product(
      {@required this.id,
      @required this.titulo,
      @required this.descricao,
      @required this.preco,
      @required this.urlDaImagem,
      this.ehFavorito = false});

  void marcarComoFavorito() {
    ehFavorito = !ehFavorito;
    notifyListeners();
  }
}
