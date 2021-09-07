import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/produtos.dart';
class DetalhesDoProdutoTela extends StatelessWidget {
  static const nomeDaRota = '/produto-detalhe';

  @override
  Widget build(BuildContext context) {

    final idDoProduto = ModalRoute.of(context).settings.arguments as String;
    
    final produtoCarregado = Provider.of<Produtos>(
      context,  
      listen: false
    ).consultePorId(idDoProduto);

    return Scaffold(
      appBar: AppBar(
        title: Text(produtoCarregado.titulo),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                produtoCarregado.urlDaImagem,
                fit: BoxFit.cover
              ),
            ),
            SizedBox(height: 10,),
            Text('R\$${produtoCarregado.preco}', style: TextStyle(color: Colors.grey, fontSize: 20),),
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                produtoCarregado.descricao, 
                textAlign: TextAlign.center, 
                softWrap: true,
              )
            )
          ],
        ),
      ),
    );
  }
}