import 'package:financeiro/model/transacao.dart';
import 'package:financeiro/widgets/barra_grafico.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

class Grafico extends StatelessWidget {
  final List<Transacao> _transacoesRecentes;

  Grafico(this._transacoesRecentes);

  List<Map<String, Object>> get grupoDeTransacoes {
    return List.generate(7, (indice) {
      final diaDaSemana = DateTime.now().subtract(Duration(days: indice));
      double somaTotalTransacoes = 0.0;

      for (var i = 0; i < _transacoesRecentes.length; i++) {
        if (_transacoesRecentes[i].data.day == diaDaSemana.day &&
            _transacoesRecentes[i].data.month == diaDaSemana.month &&
            _transacoesRecentes[i].data.year == diaDaSemana.year) {
          somaTotalTransacoes += _transacoesRecentes[i].montante;
        }
      }

      return {
        'dia': DateFormat.E().format(diaDaSemana).substring(0, 1),
        'montante': somaTotalTransacoes
      };
    }).reversed.toList();
  }

  double get _gastoMaximo {
    return grupoDeTransacoes.fold(0.0, (soma, item) {
      return soma + item['montante'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: grupoDeTransacoes.map((dados) {
              return Flexible(
                fit: FlexFit.tight,
                child: BarraGrafico(
                    dados['dia'],
                    dados['montante'],
                    dados['montante'] == 0.0
                        ? 0.0
                        : (dados['montante'] as double) / _gastoMaximo),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
