import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Transaction_list extends StatelessWidget {
  final List<Transaction> transactions;

  Transaction_list(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (ctx, index) {
          final e = transactions[index];
          return Card(
            child: Row(
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  )),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'R\$ ${e.value.toStringAsFixed(2)}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      e.title,
                      style: Theme.of(context).textTheme.titleLarge,
                      // style: TextStyle(
                      //     fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      DateFormat('d MMM y').format(e.date),
                      style: const TextStyle(color: Colors.grey),
                    )
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
