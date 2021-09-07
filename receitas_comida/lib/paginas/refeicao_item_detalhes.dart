import 'package:flutter/material.dart';

class RefeicaoItemDetalhes extends StatelessWidget {
  static const nomeDaRota = '/refeicaoItemDetalhes';

  final Function eventoSelecionarComoFavorito;
  final Function eventoVerificarSeEhFavorito;

  RefeicaoItemDetalhes(this.eventoSelecionarComoFavorito, this.eventoVerificarSeEhFavorito);


  Widget construirTitulo(BuildContext contexto, String descricao) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        descricao,
        style: Theme.of(contexto).textTheme.title,
      ),
    );
  }

  Widget construirContainer(BuildContext contexto, Widget elementoFilho) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(4)
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 200,
      width: 300,
      child: elementoFilho
    );
  }

  @override
  Widget build(BuildContext context) {
    final dados = ModalRoute.of(context).settings.arguments as Map<String, Object>; 
    final titulo = dados['titulo'];
    final ingredientes = dados['ingredientes'] as List<String>;
    final passoAPasso = dados['passoAPasso'] as List<String>;

    return Scaffold(
      appBar: AppBar(
        title: Text('$titulo'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                dados['urlDaImagem'],
                fit: BoxFit.cover,
              )
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Text('Ingredientes', style: Theme.of(context).textTheme.title)
            ),
            construirContainer(context, 
              ListView.builder(
                itemBuilder: (contexto, indice) {
                  return Card(
                    color: Theme.of(contexto).accentColor,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: Text(ingredientes[indice]),
                    ),
                  );
                },
                itemCount: ingredientes.length,
              ),
            ),
            construirTitulo(context, 'Passo a Passo'),
            construirContainer(
              context, 
              ListView.builder(
                itemBuilder: (contexto, indice) {
                  return Column(
                    children: [
                          ListTile(
                            leading: CircleAvatar(
                              child: Text('# ${(indice + 1)}'),
                            ),
                            title: Text(
                              passoAPasso[indice],
                            ),
                          ),
                          Divider()
                        ]
                  );
                },
                itemCount: passoAPasso.length,
              )
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          eventoVerificarSeEhFavorito(dados['id'].toString()) ? Icons.star : Icons.star_border,
        ),
        onPressed: () {
          //Adiciona a comida nos favoritos
          eventoSelecionarComoFavorito(dados['id'].toString());
        }
      ),
    );
  }
}