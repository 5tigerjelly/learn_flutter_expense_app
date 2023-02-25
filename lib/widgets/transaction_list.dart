import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        child: transactions.isEmpty
            ? Column(
                children: [
                  Text('No transactions yet'),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      height: 200,
                      child: Image.asset('assets/images/waiting.png',
                          fit: BoxFit.cover))
                ],
              )
            : ListView.builder(
                itemBuilder: (ctx, i) {
                  return Card(
                    child: Row(
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border.all(
                              color: Theme.of(context).primaryColor,
                              width: 2,
                            )),
                            margin: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 50,
                            ),
                            child: Text(
                              '\$${transactions[i].amount.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Theme.of(context).primaryColor,
                              ),
                            )),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              transactions[i].title,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              DateFormat.yMMMMd().format(transactions[i].date),
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
                itemCount: transactions.length,
              ));
  }
}
