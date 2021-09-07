import 'package:flutter/material.dart';

class Pergunta extends StatelessWidget {

  final String perguntaTexto;

  Pergunta(this.perguntaTexto);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(5),
      child: Text(
        perguntaTexto,
        style: TextStyle(fontSize: 28),
        textAlign: TextAlign.center,
      )
    );
  }
}
