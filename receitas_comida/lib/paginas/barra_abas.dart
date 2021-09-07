import 'package:best_food/model/refeicao.dart';

import '../widgets/drawer_principal.dart';

import 'categorias_tela.dart';
import 'package:flutter/material.dart';
import 'favoritos_tela.dart';

class BarraDeAbas extends StatefulWidget {

  final List<Refeicao> refeicoesFavoritas;
  BarraDeAbas(this.refeicoesFavoritas);

  @override
  _BarraDeAbasState createState() => _BarraDeAbasState();
}

class _BarraDeAbasState extends State<BarraDeAbas> {

  int _indiceDaPaginaSelecionada = 0;

  List<Map<String, Object>> _paginas;

  void _selecionarPagina(int indice) {
    setState(() {
      _indiceDaPaginaSelecionada = indice;
    });
  }

  @override
  void initState() { 
    super.initState();
    _paginas = [
      {
        'pagina': CategoriasTela(),
        'titulo': 'Categorias de Receitas'
      },
      {
        'pagina': FavoritosTela(widget.refeicoesFavoritas),
        'titulo': 'Meus Favoritos'
      }
    ];
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(_paginas[_indiceDaPaginaSelecionada]['titulo'])
      ),
      drawer: DrawerPrincipal(),
      body: _paginas[_indiceDaPaginaSelecionada]['pagina'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selecionarPagina,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.white,
        currentIndex: _indiceDaPaginaSelecionada,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.category), title: Text('Categorias')),
          BottomNavigationBarItem(icon: Icon(Icons.star), title: Text('Favoritos'))
        ],
      ),
    );
  }
}