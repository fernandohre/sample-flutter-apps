import 'package:flutter/material.dart';
import '../models/produto.dart';

class Produtos with ChangeNotifier {
  List<Produto> _itens = [
    Produto(
      id: 'p1',
      titulo: 'Camiseta Vermelha',
      descricao: 'Uma camisa vermelha - é bem vermelha!',
      preco: 29.99,
      urlDaImagem:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Produto(
      id: 'p2',
      titulo: 'Calças',
      descricao: 'Um par de calças.',
      preco: 59.99,
      urlDaImagem:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Produto(
      id: 'p3',
      titulo: 'Lenço Amarelo',
      descricao: 'Quente e aconchegane - Exatamente o que você precisa para o inverso.',
      preco: 19.99,
      urlDaImagem:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Produto(
      id: 'p4',
      titulo: 'Panela',
      descricao: 'Prepare qualquer refeição',
      preco: 49.99,
      urlDaImagem:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];


  List<Produto> get itens {
    return [..._itens];
  }

  List<Produto> get itensFavoritos {
    return itens.where((produto) => produto.ehFavorito).toList();
  }

  Produto consultePorId(String id) {
    return itens.firstWhere((produto) => produto.id == id);
  }

  void adicionarProduto(Produto item) {
    _itens.add(item);
    //Quando é chamado o notifyListeners
    //Toda a parte do aplicativo que estiver escutando 
    //será recarregada chamando o método build do widget
    notifyListeners();
  }
}