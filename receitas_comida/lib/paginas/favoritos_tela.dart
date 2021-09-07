import 'package:flutter/material.dart';
import '../model/refeicao.dart';
import '../widgets/refeicao_item.dart';

class FavoritosTela extends StatelessWidget {
  final List<Refeicao> favoritos;

  FavoritosTela(this.favoritos);

  @override
  Widget build(BuildContext context) {
    if (favoritos.isEmpty) {
      return Center(
        child: Text('Você não tem favoritos selecionados ainda!')
      );
    } else {
      return ListView.builder(
        itemBuilder: (contexto, indice) {
          return RefeicaoItem(
            id: favoritos[indice].id,
            titulo: favoritos[indice].titulo, 
            urlDaImagem: favoritos[indice].urlDaImagem, 
            tempoDePrepado: favoritos[indice].tempoDePreparo, 
            complexidade: favoritos[indice].complexidade, 
            tipo: favoritos[indice].tipo,
            ingredientes: favoritos[indice].ingredientes,
            passoAPasso: favoritos[indice].passoAPasso
          );
        },
        itemCount: favoritos.length,
      );
    }
    
  }
}