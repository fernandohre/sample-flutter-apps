import 'package:financeiro/model/transacao.dart';
import 'package:flutter/material.dart';

import 'item_lista_transacao.dart';

class ListaDeTransacoes extends StatelessWidget {
  
  final List<Transacao> _listaDeTransacoes;
  final Function _eventoDeletarItem;

  ListaDeTransacoes(this._listaDeTransacoes, this._eventoDeletarItem);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _listaDeTransacoes.isEmpty ? 
      LayoutBuilder(builder: (contexto, restricao) {
        return Column(
          children: <Widget>[
            Text('Sem transações para exibir'),
            SizedBox(height: 20),
            Container(
              height: restricao.maxHeight * 0.6,
              child: Image.asset('assets/images/carregando.png', 
              fit: BoxFit.cover)
            )
          ],
        );}
      ) : ListView(
        children: _listaDeTransacoes.map((transacao) => ItemTransacao(
          key: ValueKey(transacao.id),
          transacao: transacao, 
          eventoDeletarItem: _eventoDeletarItem)
        ).toList()
      ) ,
    );
  }
  
}



  
