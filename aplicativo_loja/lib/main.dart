import 'telas/order_screen.dart';

import 'telas/cart_screen.dart';
import 'providers/cart.dart';
import 'package:flutter/material.dart';
import 'providers/orders.dart';
import 'telas/products_list.dart';
import 'telas/product_detail.dart';
import 'providers/products.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Products(),
        ),
        ChangeNotifierProvider.value(value: Cart()),
        ChangeNotifierProvider.value(value: Orders())
      ],
      child: MaterialApp(
        title: 'Flutter Loja Virtual',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          colorScheme: ColorScheme.fromSwatch(),
          fontFamily: 'Lato',
        ),
        home: ListaDeProdutosTela(),
        routes: {
          ProductDetailsScreen.nomeDaRota: (_) => ProductDetailsScreen(),
          CartScreen.nomeDaRota: (_) => CartScreen(),
          OrderScreen.nomeDaRota: (_) => OrderScreen()
        },
      ),
    );
  }
}
