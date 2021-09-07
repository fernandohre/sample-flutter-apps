import 'package:flutter/material.dart';

class SacolaDeProdutos extends StatelessWidget {

  final Widget filho;
  final String valor;
  final Color cor;


  const SacolaDeProdutos({
    Key key,
    @required this.filho, 
    @required this.valor,
    this.cor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        filho, 
        Positioned(
          right: 8,
          top: 8,
          child: Container(
            padding: EdgeInsets.all(2.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: cor == null ? Theme.of(context).accentColor : cor 
            ),
            constraints: BoxConstraints(
              minWidth: 16,
              minHeight: 16
            ),
            child: Text(
              valor, 
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10
              ),
            ),
          ),
        )
      ],
    );
  }
}