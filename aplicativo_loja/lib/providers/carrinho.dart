import 'package:flutter/foundation.dart';

class ItemDoCarrinho {
  final String id;
  final String titulo;
  final int quantidade;
  final double preco;

  ItemDoCarrinho(
      {@required this.id,
      @required this.titulo,
      @required this.quantidade,
      @required this.preco});
}

class Carrinho with ChangeNotifier {
  Map<String, ItemDoCarrinho> _itens = {};

  Map<String, ItemDoCarrinho> get itens {
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
  void adicionarProduto(String id, double preco, String titulo) {
    if (_itens.containsKey(id)) {
      _itens.update(id, (itemExistente) => ItemDoCarrinho(
          id: itemExistente.id, 
          titulo: itemExistente.titulo, 
          preco: itemExistente.preco, 
          quantidade: itemExistente.quantidade + 1
        )
      );
    } else {
      _itens.putIfAbsent(
        id,
        () => ItemDoCarrinho(
            id: DateTime.now().toString(),
            titulo: titulo,
            quantidade: 1,
            preco: preco
        )
      );
    }
    notifyListeners();
  }

  void removerProduto(String id) {
    _itens.remove(id);
    notifyListeners();
  }

  void limparCarrinho() {
    _itens = {};
    notifyListeners();
  }
}
