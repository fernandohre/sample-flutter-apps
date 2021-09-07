import 'package:flutter/material.dart';

class Categoria {
  final String id;
  final String titulo;
  final Color cor;

  const Categoria({
    @required this.id, 
    @required this.titulo, 
    this.cor = Colors.orange
  });

}