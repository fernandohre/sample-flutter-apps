import 'package:flutter/material.dart';

import './pergunta.dart';
import './resposta.dart';

class Formulario extends StatelessWidget {

  final Function eventoManipulador;
  final int indice;
  final List<Map<String, Object>> perguntas;

  Formulario({
    @required this.eventoManipulador, 
    @required this.perguntas, 
    @required this.indice  
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Pergunta(perguntas.elementAt(indice)['perguntaTexto']),
        ...(perguntas[indice]['respostas'] as List<Map<String, Object>>)
            .map((resposta) {
          return Resposta(() => eventoManipulador(resposta['pontuacao']), resposta['texto']);
        }).toList(),
      ],
    );
  }
}
