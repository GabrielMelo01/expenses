import 'package:expenses/chart_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {

      final weekDay = DateTime.now().subtract(Duration(days: index),);
      double totalSum = 0.0;

      for(var i = 0; i < recentTransactions.length; i++) {
        bool sameDay = recentTransactions[i].date.day == weekDay.day;
        bool sameMonth = recentTransactions[i].date.month == weekDay.month;
        bool sameYear = recentTransactions[i].date.year == weekDay.year;
        if(sameDay && sameMonth && sameYear) {
          totalSum += recentTransactions[i].value;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay)[0],
        'value': totalSum,
      };
    });
  }

  double get _weekTotalValue {
    return groupedTransactions.fold(0.0, (sum, tr) {
      if (tr['value'] is double) {
        return sum + (tr['value'] as double);
      } else {
        // Trate o caso em que o valor não é um double
        return sum;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 6,
        margin: const EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactions.map((e) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  label: e['day'].toString(),
                  value: e['value'] as double,
                  percentage: _weekTotalValue == 0 ? 0 : (e['value'] as double) / _weekTotalValue,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
