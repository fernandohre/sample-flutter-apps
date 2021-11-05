import 'package:flutter/foundation.dart';

class ItemCart {
  final String id;
  final String titulo;
  final int quantidade;
  final double preco;

  ItemCart(
      {@required this.id,
      @required this.titulo,
      @required this.quantidade,
      @required this.preco});
}

class Cart with ChangeNotifier {
  Map<String, ItemCart> _itens = {};

  Map<String, ItemCart> get itens {
    return {..._itens};
  }

  int get quantidadeDeItens {
    return itens.length;
  }

  double get precoTotalDosItens {
    var total = 0.0;
    _itens.forEach((chave, itemDoCarrinho) {
      total += itemDoCarrinho.preco * itemDoCarrinho.quantidade;
    });
    return total;
  }

  //Método para adicionar itens no carrinho
  void add(String id, double preco, String titulo) {
    if (_itens.containsKey(id)) {
      _itens.update(
          id,
          (itemExistente) => ItemCart(
              id: itemExistente.id,
              titulo: itemExistente.titulo,
              preco: itemExistente.preco,
              quantidade: itemExistente.quantidade + 1));
    } else {
      _itens.putIfAbsent(
          id,
          () => ItemCart(
              id: DateTime.now().toString(),
              titulo: titulo,
              quantidade: 1,
              preco: preco));
    }
    notifyListeners();
  }

  void remove(String id) {
    _itens.remove(id);
    notifyListeners();
  }

  void removeSingleItem(String id) {
    if (!this._itens.containsKey(id)) return;

    if (this._itens[id].quantidade > 1) {
      this._itens.update(
          id,
          (existingItem) => ItemCart(
              id: existingItem.id,
              titulo: existingItem.titulo,
              quantidade: existingItem.quantidade - 1,
              preco: existingItem.preco));
    } else {
      this._itens.remove(id);
    }
    notifyListeners();
  }

  void clear() {
    _itens = {};
    notifyListeners();
  }
}
