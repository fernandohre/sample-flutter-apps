import 'package:aplicativo_loja/models/produto.dart';
import 'package:aplicativo_loja/providers/products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

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
  var isInit = true;
  var isLoading = false;

  var produtoEditado = Product(
      id: null, titulo: '', descricao: '', preco: null, urlDaImagem: '');

  @override
  void initState() {
    _imageBoxFocusNode.addListener(_updateUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        produtoEditado =
            Provider.of<Products>(context, listen: true).findById(productId);
        _imageUrlControler.text = produtoEditado.urlDaImagem;
      }
    }
    isInit = false;
    super.didChangeDependencies();
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
    _imageBoxFocusNode.dispose();
    _imageUrlControler.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    var isValid = _form.currentState.validate();
    if (!isValid) return;
    _form.currentState.save();
    setState(() {
      isLoading = true;
    });
    if (produtoEditado.id != null) {
      Provider.of<Products>(context, listen: false).update(produtoEditado);
    } else {
      try {
        await Provider.of<Products>(context, listen: false)
            .add(produtoEditado)
            .then((_) {
          setState(() {
            isLoading = false;
          });

          Navigator.of(context).pop();
        });
      } catch (error) {
        showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: const Text('Aconteceu um erro!'),
                  content: Text(error.toString()),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('OK'))
                  ],
                ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Editar produto'),
          actions: [
            IconButton(onPressed: _saveForm, icon: const Icon(Icons.save))
          ],
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _form,
                  child: ListView(
                    children: [
                      TextFormField(
                        initialValue: produtoEditado.titulo,
                        decoration: const InputDecoration(labelText: 'Título'),
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'O título não foi informado!';
                          }
                          //Se retornar nulo é porque ta válido.
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
                        initialValue: produtoEditado.preco.toString(),
                        decoration: const InputDecoration(labelText: 'Preço'),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        focusNode: _precoFocusNode,
                        validator: (value) {
                          if (value.isEmpty) return 'O preço não foi informado';
                          return null;
                        },
                        onFieldSubmitted: (value) {
                          FocusScope.of(context)
                              .requestFocus(_descricaoFocusNode);
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
                        initialValue: produtoEditado.descricao,
                        decoration:
                            const InputDecoration(labelText: 'Descrição'),
                        maxLines: 3,
                        focusNode: _descricaoFocusNode,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Descrição do produto é obrigatória!';
                          }

                          return null;
                        },
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
                            margin: const EdgeInsets.only(top: 8, right: 10),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey),
                            ),
                            child: _imageUrlControler.text.isEmpty
                                ? const Text('URL vazia!')
                                : FittedBox(
                                    child:
                                        Image.network(_imageUrlControler.text),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          Expanded(
                              child: TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'URL da imagem'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageUrlControler,
                            focusNode: _imageBoxFocusNode,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Informe uma URL para a imagem.';
                              }
                              if (!value.startsWith('http') &&
                                  !value.startsWith('https')) {
                                return 'URL inválida.';
                              }
                              if (!value.endsWith('.png') &&
                                  !value.endsWith('.jpg') &&
                                  !value.endsWith('.jpeg')) {
                                return 'Formato da imagem inválido! formatos válidos: png, jpg, jpeg.';
                              }
                              return null;
                            },
                            onFieldSubmitted: (_) {
                              _saveForm();
                            },
                            onSaved: (value) {
                              produtoEditado = Product(
                                  id: null,
                                  titulo: produtoEditado.titulo,
                                  descricao: produtoEditado.descricao,
                                  preco: produtoEditado.preco,
                                  urlDaImagem: value);
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
