import 'package:flutter/material.dart';

import './formulario.dart';
import './resultado.dart';

void main() => runApp(TelaInicial());

class TelaInicial extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TelaInicialState();
  }
}

class _TelaInicialState extends State<TelaInicial> {
  var _perguntaIndice = 0;
  var _pontuacaoTotal = 0;

  final _perguntas = const [
    {
      'perguntaTexto': 'Qual sua cor favorita ?',
      'respostas': [
        {'texto': 'Vermelho', 'pontuacao': 5},
        {'texto': 'Amarelo', 'pontuacao': 6},
        {'texto': 'Azul', 'pontuacao': 7},
        {'texto': 'Preto', 'pontuacao': 100}
      ],
    },
    {
      'perguntaTexto': 'Qual seu animal favorito?',
      'respostas': [
        {'texto': 'Cachorro', 'pontuacao': 5},
        {'texto': 'Gato', 'pontuacao': 5},
        {'texto': 'Hamister', 'pontuacao': 5},
        {'texto': 'Periquito', 'pontuacao': 5}
      ],
    },
    {
      'perguntaTexto': 'Qual seu time do coração',
      'respostas': [
        {'texto': 'Curintia', 'pontuacao': 1},
        {'texto': 'São Paulo', 'pontuacao': 4},
        {'texto': 'Goiás', 'pontuacao': 5},
        {'texto': 'Vila Nova', 'pontuacao': -1}
      ],
    },
  ];

  void _responderPergunta(int pontuacao) {

    _pontuacaoTotal += pontuacao;

    setState(() {
      _perguntaIndice = _perguntaIndice + 1;
    });
  }

  void _reiniciar() {

    setState(() {
      _pontuacaoTotal = 0;
      _perguntaIndice = 0;
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
        appBar: AppBar(title: Text('Jogo de Perguntas')),
        body: _perguntaIndice < _perguntas.length
            ? Formulario(
                eventoManipulador: _responderPergunta,
                perguntas: _perguntas,
                indice: _perguntaIndice)
            : Resultado(_pontuacaoTotal, _reiniciar),
      )
    );
  }
}
