import 'package:flutter/foundation.dart';

class Produto with ChangeNotifier{
  final String id;
  final String titulo;
  final String descricao;
  final double preco;
  final String urlDaImagem;
  bool ehFavorito;

  Produto({
    @required this.id,
    @required this.titulo,
    @required this.descricao,
    @required this.preco,
    @required this.urlDaImagem,
    this.ehFavorito = false
  });

  void marcarComoFavorito() {
    ehFavorito = !ehFavorito;
    notifyListeners();
  }
}
