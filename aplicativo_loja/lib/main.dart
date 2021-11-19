import 'package:aplicativo_loja/widgets/user_products_screen.dart';

import 'screens/order_screen.dart';

import 'screens/cart_screen.dart';
import 'providers/cart.dart';
import 'package:flutter/material.dart';
import 'providers/orders.dart';
import 'screens/products_list.dart';
import 'screens/product_detail.dart';
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
            primaryColor: Colors.purple,
            colorScheme: ColorScheme.fromSwatch(accentColor: Colors.deepOrange),
            fontFamily: 'Lato',
            appBarTheme: AppBarTheme(backgroundColor: Colors.purple)),
        home: ListaDeProdutosTela(),
        routes: {
          ProductDetailsScreen.routeName: (_) => ProductDetailsScreen(),
          CartScreen.routeName: (_) => CartScreen(),
          OrderScreen.routeName: (_) => OrderScreen(),
          UserProductsScreen.routeName: (_) => UserProductsScreen()
        },
      ),
    );
  }
}
