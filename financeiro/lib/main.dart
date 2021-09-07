import 'package:financeiro/model/transacao.dart';
import 'package:financeiro/widgets/grafico.dart';
import 'package:financeiro/widgets/lista_transacao.dart';
import 'package:financeiro/widgets/nova_transacao.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:uuid/uuid.dart';

void main() {
  //Força o usuário usar no modo portrait
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitUp
  // ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        // ... app-specific localization delegate[s] here
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('pt')
      ],
      title: 'Aplicativo Financeiro Pessoal',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        errorColor: Colors.red,
        fontFamily: 'Quicksand',
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
              fontFamily: 'OpenSans', 
              fontSize: 20.0,
              fontWeight: FontWeight.bold
            ),
            button: TextStyle(color: Colors.white)
          )
        )
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
/*
 * A palavra with serve para herdar propriedades de uma outra classe
 * que geralmente está relacionada a infraestrutura do dispositivo e comportamentos
 * do sistema operacional Android ou IOS ou infraestrutura de alguma biblioteca de terceiros.
 */
class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  //Aqui é definido a lista, pelo simples fato de que ela
  //é gerenciada no "componente/widget" pai
  final List<Transacao> _lista = [];
  final id = Uuid();
  bool _mostrarGrafico = false;

  @override
  void initState() { 
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState estado) {
    print(estado);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  final _appBar = AppBar(
    title: Text("Aplicativo Financeiro")
  );
  /*
   * Adiciona uma nova transação na _lista e altera o estado da ListView 
   */
  void _adicionarNovaTransacao(String descricao, double montante, DateTime dataSelecionada) {

    final novaTransacao = new Transacao(
      descricao: descricao, 
      montante: montante, 
      data: dataSelecionada, 
      id: id.v1()
    );
    //Alterando estado da Lista
    //Adicionando uma nova transação
    setState(() {
      _lista.add(novaTransacao);
    });
  }

  /*
   * Remove da _lista e altera o estado da ListView, reconstruindo todo 
   * o componente
   */
  void _removerTransacao(String id) {

    setState(() {
      _lista.removeWhere((item) => item.id == id);
    });

  }

  /*
   * Exibe o componente de nova transação, possibilitando informar a descrição
   * e o montante gasto.
   */
  void _inicieNovaTransacao(BuildContext contexto) {
    showModalBottomSheet(
      context: contexto, 
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NovaTransacao(_adicionarNovaTransacao),
          behavior: HitTestBehavior.opaque,
        ); 
      }
    );
  }

  List<Transacao> get _ultimasTransacoes {
    return _lista.where((transacao) {
      return transacao.data.isAfter(
        DateTime.now().subtract(
          Duration(days: 7)
        )
      );
    }).toList();
  }

  Widget _modoRetrato(MediaQueryData mediaQuery) {
    return Container(
      height: (mediaQuery.size.height - _appBar.preferredSize.height - mediaQuery.padding.top) * 0.3,
      child: Grafico(_ultimasTransacoes)
    );
  }

  Widget _modoPaisagem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Exibir Gráfico'),
        Switch(value: _mostrarGrafico, onChanged: (val) {
          setState(() {
            _mostrarGrafico = val;
          });
        },)
      ],
    );
  }

  Widget build(BuildContext context) {
    final modoPaisagem = MediaQuery.of(context).orientation == Orientation.landscape;

    final mediaQuery = MediaQuery.of(context);

    final _transacoesWidget = Container(
      height: (mediaQuery.size.height - _appBar.preferredSize.height - mediaQuery.padding.top) * 0.7,
      child: ListaDeTransacoes(_lista, _removerTransacao)
    );

    return Scaffold(
      appBar: _appBar,
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (modoPaisagem) _modoPaisagem(),
            if (!modoPaisagem) _modoRetrato(mediaQuery),
            if (!modoPaisagem) _transacoesWidget,
            if (modoPaisagem) _mostrarGrafico ? Container(
              height: (mediaQuery.size.height - _appBar.preferredSize.height - mediaQuery.padding.top) * 0.3,
              child: Grafico(_ultimasTransacoes)
            ) :
            _transacoesWidget
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add), 
        onPressed: () => _inicieNovaTransacao(context),
      ),
    );
  }
}

