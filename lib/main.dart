import 'package:flutter/material.dart';
import './widgets/chart.dart';
import './models/transaction.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          fontFamily: 'Quicksand',
          appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // final List<Transaction> _userTransaction = [
  //   Transaction(
  //       id: 't1', title: 'New Shoe', amount: 69.99, date: DateTime.now()),
  //   Transaction(
  //       id: 't2',
  //       title: 'Weekly Grocierys',
  //       amount: 16.53,
  //       date: DateTime.now()),
  //   Transaction(
  //       id: 't3',
  //       title: 'Weekly Grocierys',
  //       amount: 16000.53,
  //       date: DateTime.now()),
  //   Transaction(
  //       id: 't1', title: 'New Shoe', amount: 69.99, date: DateTime.now()),
  //   Transaction(
  //       id: 't2',
  //       title: 'Weekly Grocierys',
  //       amount: 16.53,
  //       date: DateTime.now()),
  //   Transaction(
  //       id: 't3',
  //       title: 'Weekly Grocierys',
  //       amount: 16000.53,
  //       date: DateTime.now()),
  //   Transaction(
  //       id: 't1', title: 'New Shoe', amount: 69.99, date: DateTime.now()),
  //   Transaction(
  //       id: 't2',
  //       title: 'Weekly Grocierys',
  //       amount: 16.53,
  //       date: DateTime.now()),
  //   Transaction(
  //       id: 't3',
  //       title: 'Weekly Grocierys',
  //       amount: 16000.53,
  //       date: DateTime.now())
  // ];

  List<Transaction> get _recentTransactions {
    return _userTransaction.where((element) {
      return element.date.isAfter(
        DateTime.now().subtract(Duration(days: 7)),
      );
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime chosenDate) {
    final newTransaction = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: chosenDate,
    );

    setState(() {
      _userTransaction.add(newTransaction);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Expenses'),
        actions: [
          IconButton(
              onPressed: () => _startAddNewTransaction(context),
              icon: Icon(Icons.add))
        ],
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Chart(_recentTransactions),
          ),
          Expanded(
              child: TransactionList(_userTransaction, _deleteTransaction)),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
