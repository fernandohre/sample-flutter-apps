
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NovaTransacao extends StatefulWidget {

  final Function eventoNovaTransacao;

  NovaTransacao(this.eventoNovaTransacao) {
    print('Construtor: NovaTransacao');
  }

  @override
  _NovaTransacaoState createState() {
    print('Criando estado: NovaTransacao');
    return _NovaTransacaoState();
  }
}

class _NovaTransacaoState extends State<NovaTransacao> {
  //Campos da tela 
  final descricaoController = TextEditingController();
  final montanteController = TextEditingController();

  DateTime _dataSelecionada;

  _NovaTransacaoState() {
    print('Construtor _NovaTransacaoState State');
  }

  @override
  void initState() {
    print('initState NovaTransacao Widget');
    super.initState();
  }

  @override
  void didUpdateWidget (NovaTransacao oldWidget) {
    print('didUpdateWidget NovaTransacao');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    print('dispose() NovaTransacao');
    super.dispose();
  }

  void _enviarDados() {

    if (descricaoController.text.isEmpty || 
      double.parse(montanteController.text) <= 0 ||
      _dataSelecionada == null) {
      return;
    }

    widget.eventoNovaTransacao(
      descricaoController.text,
      double.parse(montanteController.text),
      _dataSelecionada
    );
    //Quanda acontecer o clique no botão de adicionar nova transação
    //isso aqui fará com que o componente suma da tela
    Navigator.of(context).pop();
  }

  void _mostrarSeletorDeData() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime.now(),
      locale: Locale('pt')
    ).then((dataSelecionada) {
      if (dataSelecionada == null) {
        return;
      }
      //Alterando o estado
      setState(() {
        _dataSelecionada = dataSelecionada;
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView( //tornar o widget scrollável se não caber na tela
          child: Card(
          elevation: 5,
          child: Container(
            padding: EdgeInsets.only(
              top: 10, 
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Descrição'
                  ),
                  controller: descricaoController,
                  onSubmitted: (_) => _enviarDados,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Montante'
                  ),
                  controller: montanteController,
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) => _enviarDados,
                ),
                Container(
                  height: 70,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(_dataSelecionada == null ? 
                          'Selecione a data' : 
                          'Data Selecionada: ${DateFormat('dd/MM/yyyy').format(_dataSelecionada)}')
                        ),
                      FlatButton(
                        textColor: Theme.of(context).primaryColor,
                        child: Text(
                          'Selecionar data', 
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ), 
                        onPressed: _mostrarSeletorDeData,
                      )
                    ],
                  ),
                ),
                RaisedButton(
                  child: Text('Adicionar nova transação'),
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).appBarTheme.textTheme.button.color,
                  onPressed: _enviarDados,
                )
              ],
            )
          )
        ),
      ),
    );
  }
}