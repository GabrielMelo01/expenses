import 'dart:math';

import 'package:expenses/chart.dart';
import 'package:expenses/models/transaction.dart';
import 'package:expenses/transaction_form.dart';
import 'package:expenses/transaction_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData();

    return MaterialApp(
      home: MyHomePage(),
      theme: tema.copyWith(
        colorScheme: tema.colorScheme.copyWith(
          primary: Colors.purple[500],
          secondary: Colors.amber,
        ),
        textTheme: tema.textTheme.copyWith(
          headline6: const TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 20,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    // Transaction(
    //   id: 't0',
    //   title: 'Conta Antiga',
    //   value: 400.00,
    //   date: DateTime.now().subtract(Duration(days: 33)),
    // ),
    // Transaction(
    //   id: 't1',
    //   title: 'Novo Tênis de Corrida',
    //   value: 310.76,
    //   date: DateTime.now().subtract(Duration(days: 3)),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Conta de Luz',
    //   value: 211.30,
    //   date: DateTime.now().subtract(Duration(days: 4)),
    // ),
    // Transaction(
    //   id: 't3',
    //   title: 'Conta de Agua',
    //   value: 67.50,
    //   date: DateTime.now().subtract(Duration(days: 4)),
    // ),
    // Transaction(
    //   id: 't4',
    //   title: 'IPVA',
    //   value: 567.10,
    //   date: DateTime.now().subtract(Duration(days: 4)),
    // ),
  ];

  List<Transaction> get _recentTransactions {
    return _transactions.where((e) {
      return e.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: date);

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((e) => e.id == id);
    });
  }

  // _openTransactionFormModal(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (_) {
  //       return TransactionForm(_addTransaction);
  //     },
  //   );
  // }
  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: TransactionForm(_addTransaction),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final avaliableHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: AppBar(
        title: Text('Despesas Pessoais',
            style: TextStyle(
              fontSize: 20 * MediaQuery.of(context).textScaleFactor,
            )),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _openTransactionFormModal(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              child: Chart(_recentTransactions),
              height: avaliableHeight * 0.30,
            ),
            Container(
              height: avaliableHeight * 0.70,
              child: Transaction_list(_recentTransactions, _removeTransaction),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openTransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
