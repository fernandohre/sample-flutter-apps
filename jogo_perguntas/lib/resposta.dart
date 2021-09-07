import 'package:flutter/material.dart';

class Resposta extends StatelessWidget {
  final Function eventoManipulador;
  final String descricao;

  Resposta(this.eventoManipulador, this.descricao);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        color: Colors.blue,
        textColor: Colors.white,
        child: Text(descricao),
        onPressed: eventoManipulador,
      ),
    );
  }
}