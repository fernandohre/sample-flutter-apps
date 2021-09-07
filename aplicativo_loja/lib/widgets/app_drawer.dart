import '../telas/pedidos_tela.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('testando drawer'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Realizar compras'),
            onTap: () {
              //Volta para a home page
              Navigator.of(context).pushNamed('/');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Pedidos'),
            onTap: () {
              //Volta para a home page
              Navigator.of(context).pushNamed(PedidosTela.nomeDaRota);
            },
          )
        ],
      ),
    );
  }
}