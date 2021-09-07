import 'package:financeiro/model/transacao.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';
class ItemTransacao extends StatefulWidget {
  const ItemTransacao({
    Key key,
    @required Transacao transacao,
    @required Function eventoDeletarItem
  }) : _transacao = transacao, _eventoDeletarItem = eventoDeletarItem, super(key: key);

  final Transacao _transacao;
  final Function _eventoDeletarItem;

  @override
  _ItemTransacaoState createState() => _ItemTransacaoState();
}

class _ItemTransacaoState extends State<ItemTransacao> {
  Color _corDeFundo;

  @override
  void initState() {
    const coresDisponiveis = [
      Colors.red,
      Colors.black, 
      Colors.blue, 
      Colors.purple
    ];
    _corDeFundo = coresDisponiveis[Random().nextInt(coresDisponiveis.length)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _corDeFundo,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: FittedBox(
              child: Text('\$${widget._transacao.montante}')
            ),
          ),
        ),
        title: Text(
          widget._transacao.descricao, 
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          DateFormat.yMd().format(widget._transacao.data),
        ),
        trailing: MediaQuery.of(context).size.width > 360 
          ? FlatButton.icon(
              onPressed: () => widget._eventoDeletarItem(widget._transacao.id), 
              icon: const Icon(Icons.delete), 
              label: const Text('Excluir'),
              textColor: Theme.of(context).errorColor,
            ) 
          : IconButton(
            iconSize: 38,
            color: Theme.of(context).errorColor,
            icon: Icon(Icons.delete), 
            onPressed: () => widget._eventoDeletarItem(widget._transacao.id),
          ),
      ),
    );
  }
}