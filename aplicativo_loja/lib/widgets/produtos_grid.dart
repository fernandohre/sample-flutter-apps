import '../providers/produtos.dart';
import '../widgets/produto_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProdutosGrid extends StatelessWidget {
  final bool mostrarSomenteFavoritos;

  ProdutosGrid(this.mostrarSomenteFavoritos); 

  @override
  Widget build(BuildContext context) {
    final dados = Provider.of<Produtos>(context);
    final listaDeProdutos = mostrarSomenteFavoritos ? dados.itensFavoritos : dados.itens;
    
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, 
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10
      ), 
      itemBuilder: (contexto, indice) => ChangeNotifierProvider.value(
        value: listaDeProdutos[indice],
        child: ItemProduto(),
      ),
      itemCount: listaDeProdutos.length,
    );
  }
}