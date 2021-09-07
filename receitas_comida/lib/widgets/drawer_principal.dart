import '../paginas/filtros_tela.dart';
import 'package:flutter/material.dart';

class DrawerPrincipal extends StatelessWidget {


  Widget construirListTile(String texto, IconData icone, Function evento) {
    return ListTile(
      leading: Icon(icone, size: 26),
      title: Text(
        texto, 
        style: TextStyle(
          fontFamily: 'RobotoCondensed', 
          fontSize: 24, 
          fontWeight: FontWeight.bold
        )
      ),
      onTap: evento,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 120,
            width: double.infinity, // Ocupar todo o tamanho da tela disponível
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).accentColor,
            child: Text(
              'Cardápio', 
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
                color: Theme.of(context).primaryColor
              )
            ),
          ),
          SizedBox(height: 20,),
          construirListTile(
            'Refeições', 
            Icons.restaurant,
            () {
              Navigator.of(context).pushReplacementNamed('/');
            }
          ),
          construirListTile(
            'Filtros', 
            Icons.settings,
            () {
              Navigator.of(context).pushReplacementNamed(FiltrosTela.nomeDaRota);
            }
          )
        ],
      ),
    );
  }
}