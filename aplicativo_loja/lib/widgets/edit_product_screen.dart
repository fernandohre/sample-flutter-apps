import 'package:aplicativo_loja/models/produto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';
  @override
  _EditProductScreen createState() => _EditProductScreen();
}

class _EditProductScreen extends State<EditProductScreen> {
  final _precoFocusNode = FocusNode();
  final _descricaoFocusNode = FocusNode();
  final _imageUrlControler = TextEditingController();
  final _imageBoxFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();

  var produtoEditado = new Product(
      id: null, titulo: '', descricao: '', preco: null, urlDaImagem: '');

  @override
  void initState() {
    // TODO: implement initState
    _imageBoxFocusNode.addListener(_updateUrl);
    super.initState();
  }

  void _updateUrl() {
    if (!_imageBoxFocusNode.hasFocus) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _imageBoxFocusNode.removeListener(_updateUrl);
    _descricaoFocusNode.dispose();
    _descricaoFocusNode.dispose();
    _imageBoxFocusNode.dispose();
    _imageUrlControler.dispose();
    super.dispose();
  }

  void _saveForm() {
    _form.currentState.validate();
    _form.currentState.save();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Editar produto'),
          actions: [IconButton(onPressed: _saveForm, icon: Icon(Icons.save))],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _form,
            child: ListView(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Título'),
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value.isEmpty) return 'O título não foi informado!';
                    return null;
                  },
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(_precoFocusNode);
                  },
                  onSaved: (value) => {
                    produtoEditado = Product(
                        id: null,
                        titulo: value,
                        descricao: produtoEditado.descricao,
                        preco: produtoEditado.preco,
                        urlDaImagem: produtoEditado.urlDaImagem)
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Preço'),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _precoFocusNode,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(_descricaoFocusNode);
                  },
                  onSaved: (value) {
                    produtoEditado = Product(
                        id: null,
                        titulo: produtoEditado.titulo,
                        descricao: produtoEditado.descricao,
                        preco: double.parse(value),
                        urlDaImagem: produtoEditado.urlDaImagem);
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Descrição'),
                  maxLines: 3,
                  focusNode: _descricaoFocusNode,
                  keyboardType: TextInputType.multiline,
                  onSaved: (value) {
                    produtoEditado = Product(
                        id: null,
                        titulo: produtoEditado.titulo,
                        descricao: value,
                        preco: produtoEditado.preco,
                        urlDaImagem: produtoEditado.urlDaImagem);
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(top: 8, right: 10),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                      ),
                      child: _imageUrlControler.text.isEmpty
                          ? Text('URL vazia!')
                          : FittedBox(
                              child: Image.network(_imageUrlControler.text),
                              fit: BoxFit.cover,
                            ),
                    ),
                    Expanded(
                        child: TextFormField(
                      decoration: InputDecoration(labelText: 'URL da imagem'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlControler,
                      focusNode: _imageBoxFocusNode,
                      onSaved: (value) {
                        produtoEditado = Product(
                            id: null,
                            titulo: value,
                            descricao: produtoEditado.descricao,
                            preco: produtoEditado.preco,
                            urlDaImagem: value);
                        _saveForm();
                      },
                    ))
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
