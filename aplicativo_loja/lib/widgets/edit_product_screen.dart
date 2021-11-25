import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';
  @override
  _EditProductScreen createState() => _EditProductScreen();
}

class _EditProductScreen extends State<EditProductScreen> {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Editar produto'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            child: ListView(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Título'),
                  textInputAction: TextInputAction.next,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Preço'),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                )
              ],
            ),
          ),
        ));
  }
}
