import '../model/refeicao.dart';
import '../widgets/refeicao_item.dart';
import 'package:flutter/material.dart';

class CategoriaItemDetalhes extends StatefulWidget {
  static const nomeDaRota = '/categoriaItemDetalhes';
  final  List<Refeicao> refeicoesDisponiveis;

  CategoriaItemDetalhes(this.refeicoesDisponiveis);

  @override
  _CategoriaItemDetalhesState createState() => _CategoriaItemDetalhesState();
}

class _CategoriaItemDetalhesState extends State<CategoriaItemDetalhes> {

  String categoriaTitulo;
  List<Refeicao> refeicoesListadas;
  bool _dadosEstaoCarregados = false;

  void _removaRefeicaoDaCategoria(String id) {
    setState(() {
      refeicoesListadas.removeWhere((item) => item.id == id);
    });
  }
  // Aqui o contexto já está inicializado, ao contrário do initState,
  //que durante o ciclo de vida do widget, não tem o contexto inicializado ao iniciar o estado.
  @override
  void didChangeDependencies() {
    //Se não tiver esse if, ele vai recarregar toda a lista de refeições da categoria de novo
    // e não vai deletar
    if (!_dadosEstaoCarregados) {
      final argumentosDaRota = ModalRoute.of(context).settings.arguments as Map<String, String>;
      final idDaCategoria = argumentosDaRota['id'];
      categoriaTitulo = argumentosDaRota['titulo'];
      refeicoesListadas = widget.refeicoesDisponiveis.where((refeicao) => refeicao.categorias.contains(idDaCategoria)).toList();
      _dadosEstaoCarregados = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoriaTitulo)
      ),
      body: ListView.builder(
        itemBuilder: (contexto, indice) {
          return RefeicaoItem(
            id: refeicoesListadas[indice].id,
            titulo: refeicoesListadas[indice].titulo, 
            urlDaImagem: refeicoesListadas[indice].urlDaImagem, 
            tempoDePrepado: refeicoesListadas[indice].tempoDePreparo, 
            complexidade: refeicoesListadas[indice].complexidade, 
            tipo: refeicoesListadas[indice].tipo,
            ingredientes: refeicoesListadas[indice].ingredientes,
            passoAPasso: refeicoesListadas[indice].passoAPasso,
            eventoRemoverItem: _removaRefeicaoDaCategoria,
          );
        },
        itemCount: refeicoesListadas.length,
      ),
    );
  }
}
