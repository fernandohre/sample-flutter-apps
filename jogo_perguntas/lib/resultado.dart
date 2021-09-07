import 'package:flutter/material.dart';

class Resultado extends StatelessWidget {
  final int pontuacaoTotal;
  final Function eventoReiniciar;

  Resultado(this.pontuacaoTotal, this.eventoReiniciar);

  String get exibaResultado {
    var textoFinal = 'Você fez uma boa pontuação!';

    if (pontuacaoTotal <= 7) {
      textoFinal = 'Aumente sua pontuação!';
    } else if (pontuacaoTotal <= 10) {
      textoFinal = 'É isso ai, continue assim!';
    }

    return textoFinal;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Text(
            exibaResultado,
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          FlatButton(child: Text("Reiniciar"), onPressed: eventoReiniciar,)
        ],
      ),
    );
  }
}
