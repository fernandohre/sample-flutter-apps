import 'package:best_food/paginas/filtros_tela.dart';
import 'package:best_food/refeicoes_mock.dart';

import 'model/refeicao.dart';
import 'paginas/barra_abas.dart'; 
import 'paginas/categoria_item_detalhes.dart';
import 'package:flutter/material.dart';
import 'paginas/refeicao_item_detalhes.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Map<String, bool> _filtros = {
    'semGlutem': false,
    'semLactose': false,
    'vegetariana': false
  };

  List<Refeicao> _refeicoesDisponiveis = REFEICOES_MOCK;
  List<Refeicao> _refeicoesFavoritas = [];

  void _alterarFiltros(Map<String, bool> configuracao) {
    setState(() {
      _filtros = configuracao;
      _refeicoesDisponiveis = REFEICOES_MOCK.where((refeicao) {

        if (_filtros['vegetariana'] && !refeicao.ehVegetariano) {
          return false;
        }
        if (_filtros['semLactose'] && !refeicao.semLactose) {
          return false;
        }
        if (_filtros['semGlutem'] && !refeicao.semGlutem) {
          return false;
        }
        return true;
        
      }).toList();
    });
  }

  void _selecionarFavoritos(String id) {
    final indiceExistente = _refeicoesFavoritas.indexWhere((refeicao) => refeicao.id == id);
    if (indiceExistente >= 0) {
      setState(() {
        _refeicoesFavoritas.removeAt(indiceExistente);
      });
    } else {
      setState(() {
        _refeicoesFavoritas.add(REFEICOES_MOCK.firstWhere((refeicao) => refeicao.id == id));
      });
    }
  }

  bool _refeicaoEhFavorita(String id) {
    return _refeicoesFavoritas.any((refeicao) => refeicao.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.blue.shade300,
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
          body1: TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1)
          ),
          body2: TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1)
          ),
          title: TextStyle(
            fontSize: 24,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold
          )
        )
      ),
      // home: CategoriasTela(),
      routes: {
        '/': (contexto) => BarraDeAbas(_refeicoesFavoritas),
        CategoriaItemDetalhes.nomeDaRota: (contexto) => CategoriaItemDetalhes(_refeicoesDisponiveis),
        RefeicaoItemDetalhes.nomeDaRota: (contexto) => RefeicaoItemDetalhes(_selecionarFavoritos, _refeicaoEhFavorita),
        FiltrosTela.nomeDaRota: (contexto) => FiltrosTela(_filtros, _alterarFiltros)
      },
    );
  }
}

