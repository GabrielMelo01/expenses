import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Transaction_list extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;

  Transaction_list(this.transactions, this.onRemove);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Column(
            children: [
              Text(
                'Nenhuma Transação Cadastrada!',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 200,
                child: Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover,
                ),
              )
            ],
          )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              final e = transactions[index];
              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: FittedBox(
                          child: Text(
                              'R\$ ${e.value.toStringAsFixed(2).replaceAll(".", ",")}')),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  title: Text(
                    e.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  subtitle: Text(
                    DateFormat('d MMM y').format(e.date),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    color: Theme.of(context).colorScheme.error,
                    onPressed: () => onRemove(e.id),
                  ),
                ),
              );
            },
          );
  }
}
