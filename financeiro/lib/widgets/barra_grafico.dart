import 'package:flutter/material.dart';

class BarraGrafico extends StatelessWidget {
  final String label;
  final double gasto;
  final double porcentagemTotal;

  const BarraGrafico(this.label, this.gasto, this.porcentagemTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (contexto, restricao) {
      return Column(
        children: <Widget>[
          Container(
            height: restricao.maxHeight * 0.15,
            child: FittedBox(
              child: Text('\$${gasto.toStringAsFixed(0)}')
            ),
          ),
          SizedBox(
            height: restricao.maxHeight * 0.05,
          ),
          Container(
            height: restricao.maxHeight * 0.6, 
            width: 10,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10)
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: porcentagemTotal, 
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: restricao.maxHeight * 0.05,),
          Container(
            height: restricao.maxHeight * 0.15,
            child: FittedBox(
              child: Text(label)
            )
          )
        ],
      );
    });
  }
}