import '../widgets/categoria_item.dart';
import 'package:flutter/material.dart';
import '../categorias_mock.dart';

class CategoriasTela extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(25),
      children: CATEGORIAS_MOCK.map((item) {
        return CategoriaItem(
          item.id, 
          item.titulo, 
          item.cor
        );
      }).toList(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20
      ),
    );
  }
}
