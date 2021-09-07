import '../widgets/drawer_principal.dart';
import 'package:flutter/material.dart';

class FiltrosTela extends StatefulWidget {
  static const nomeDaRota = '/filtros';
  final Function eventoAlterarConfiguracaoFiltro;
  final Map<String, bool> configuracaoAtual;

  FiltrosTela(this.configuracaoAtual, this.eventoAlterarConfiguracaoFiltro);

  @override
  _FiltrosTelaState createState() => _FiltrosTelaState();
}

class _FiltrosTelaState extends State<FiltrosTela> {

  bool _semGlutem = false;
  bool _vegetariana = false;
  bool _semLactose = false;

  @override
  void initState() {
    _semGlutem = widget.configuracaoAtual['semGlutem'];
    _vegetariana = widget.configuracaoAtual['vegetariana'];
    _semLactose = widget.configuracaoAtual['semLactose'];
    super.initState();
  }

  Widget _construirSwitchListTile(String titulo, String descricao, bool flagAtual, Function eventoAtualizarFlag) {
    return SwitchListTile(
      title: Text(titulo),
      value: flagAtual,
      subtitle: Text(descricao),
      onChanged: eventoAtualizarFlag,  
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus filtros'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final filtros = {
                'semGlutem': _semGlutem,
                'semLactose': _semLactose,
                'vegetariana': _vegetariana
              };
              widget.eventoAlterarConfiguracaoFiltro(filtros);
            },
          )
        ],
      ),
      drawer: DrawerPrincipal(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Configurar filtros', 
              style: Theme.of(context).textTheme.title
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _construirSwitchListTile(
                  'Sem glútem', 
                  'Exibir apenas refeições sem glútem',
                  _semGlutem,
                  (novoFlag) {
                    setState((){
                      _semGlutem = novoFlag;
                    });
                  }
                ),
                _construirSwitchListTile(
                  'Vegetariana', 
                  'Exibir refeições vegetarianas', 
                  _vegetariana, 
                  (novoFlag) {
                    setState(() {
                      _vegetariana = novoFlag;
                    });
                  }
                ),
                _construirSwitchListTile(
                  'Sem Lactose', 
                  'Exibir refeições sem lactose', 
                  _semLactose, 
                  (novoFlag) {
                    setState(() {
                      _semLactose = novoFlag;
                    });
                  }
                )
              ]
            ),
          )
        ],
      ),
    );
  }
} 