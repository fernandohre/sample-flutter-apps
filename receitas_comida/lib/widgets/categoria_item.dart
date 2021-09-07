import 'package:flutter/material.dart';

import '../paginas/categoria_item_detalhes.dart';

class CategoriaItem extends StatelessWidget {
  final String id;
  final String titulo;
  final Color cor;

  CategoriaItem(this.id, this.titulo, this.cor);

  void categoriaSelecionada(BuildContext contexto) {
    //Utilizando o navigator, aqui está jogando a tela para o topo
    // na pilha de telas, utilizando o route do material
    Navigator.of(contexto).pushNamed(
      CategoriaItemDetalhes.nomeDaRota,
      arguments: {
        'id': id,
        'titulo': titulo
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => categoriaSelecionada(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(
          titulo,
          style: Theme.of(context).textTheme.title,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            cor.withOpacity(0.45),
            cor,
          ], begin: Alignment.topRight, end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
