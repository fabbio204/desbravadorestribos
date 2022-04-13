import 'package:flutter_modular/flutter_modular.dart';
import 'package:desbravadores_tribos/app/modules/financeiro/financeiro_store.dart';
import 'package:flutter/material.dart';

class FinanceiroPage extends StatefulWidget {
  final String title;
  const FinanceiroPage({Key? key, this.title = 'FinanceiroPage'})
      : super(key: key);
  @override
  FinanceiroPageState createState() => FinanceiroPageState();
}

class FinanceiroPageState extends State<FinanceiroPage> {
  final FinanceiroStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Financeiro'),
    );
  }
}
