import 'package:best_food/model/refeicao.dart';
import 'package:flutter/material.dart';

import '../paginas/refeicao_item_detalhes.dart';

class RefeicaoItem extends StatelessWidget {
  final String id;
  final String titulo;
  final String urlDaImagem;
  final int tempoDePrepado;
  final ComplexidadeDaReceita complexidade;
  final TipoDeComida tipo;
  final List<String> ingredientes;
  final List<String> passoAPasso;
  final Function eventoRemoverItem;

  RefeicaoItem({
    @required this.id,
    @required this.titulo,
    @required this.urlDaImagem,
    @required this.tempoDePrepado,
    @required this.complexidade,
    @required this.tipo,
    @required this.ingredientes,
    @required this.passoAPasso,
    this.eventoRemoverItem
  });

  void selecionarRefeicao(BuildContext contexto) {
    Navigator.of(contexto).pushNamed(
      RefeicaoItemDetalhes.nomeDaRota,
      arguments: {
        'id': id,
        'urlDaImagem': urlDaImagem,
        'titulo': titulo,
        'ingredientes': ingredientes,
        'passoAPasso': passoAPasso
      }
    ).then((resultado) {
      if (resultado != null) {
        eventoRemoverItem(resultado);
      }
    });
  }

  String get complexidadeTexto {
    if (complexidade == ComplexidadeDaReceita.Simples) {
      return 'Simples';
    } else if (complexidade == ComplexidadeDaReceita.Intermediario) {
      return 'Intermediário';
    } else if (complexidade == ComplexidadeDaReceita.Dificil) {
      return 'Difícil';
    }
    return 'Não classificado';
  }

  String get custoRefeicaoTexto {
    if (tipo == TipoDeComida.Acessivel) {
      return 'Acessível';
    } else if (tipo == TipoDeComida.CustoAlto) {
      return 'Custo Alto';
    } else if (tipo == TipoDeComida.Luxuosa) {
      return 'Luxuosa';
    }
    return 'Não classificado';
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selecionarRefeicao(context),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    // bottomRight: Radius.circular(15),
                    topRight: Radius.circular(15),
                    // bottomLeft: Radius.circular(15)
                  ),
                  child: Image.network(
                    urlDaImagem, 
                    height: 250, 
                    width: double.infinity, 
                    fit: BoxFit.cover
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 10, 
                  child: Container(
                    color: Colors.black38,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    width: 220,
                    child: Text(
                      titulo, 
                      style: TextStyle(
                        fontSize: 26, 
                        color: Colors.white,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.schedule),
                      SizedBox(width: 6,),
                      Text('$tempoDePrepado min')
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.work),
                      SizedBox(width: 6,),
                      Text(complexidadeTexto)
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.attach_money),
                      SizedBox(width: 6,),
                      Text(custoRefeicaoTexto)
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
