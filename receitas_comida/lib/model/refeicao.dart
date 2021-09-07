import 'package:flutter/foundation.dart';

enum ComplexidadeDaReceita {
  Simples,
  Intermediario,
  Dificil
}

enum TipoDeComida {
  Acessivel,
  CustoAlto,
  Luxuosa
}

class Refeicao {
  final String id;
  final List<String> categorias;
  final String titulo;
  final String urlDaImagem;
  final List<String> ingredientes;
  final List<String> passoAPasso;
  final int tempoDePreparo; 
  final ComplexidadeDaReceita complexidade;
  final TipoDeComida tipo;
  final bool semGlutem;
  final bool semLactose;
  final bool ehVegetariano;

  const Refeicao({
    @required this.id, 
    @required this.categorias, 
    @required this.titulo, 
    @required this.urlDaImagem, 
    @required this.ingredientes, 
    @required this.passoAPasso, 
    @required this.tempoDePreparo, 
    @required this.complexidade, 
    @required this.tipo,
    @required this.semGlutem,
    @required this.semLactose,
    @required this.ehVegetariano
  });
}