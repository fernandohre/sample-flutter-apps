import 'package:flutter/foundation.dart';

class Transacao {
  String id;
  String descricao;
  double montante;
  DateTime data;

  Transacao({
    @required this.id, 
    @required this.descricao, 
    @required this.montante, 
    @required this.data
  });
}
