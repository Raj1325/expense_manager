import 'package:expense_manager/modal/transactions.dart';
import 'package:expense_manager/widget/chart_bar.dart';
import "package:flutter/material.dart";
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> _rescentTransaction;

  Chart(this._rescentTransaction) {
    print(_rescentTransaction);
  }

  List<Map<String, Object>> get transactionForWeek {
    return List.generate(7, (index) {
      DateTime day = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0;

      for (int i = 0; i < _rescentTransaction.length; i++) {
        if (_rescentTransaction[i].time.day == day.day &&
            _rescentTransaction[i].time.month == day.month &&
            _rescentTransaction[i].time.year == day.year) {
          totalSum += _rescentTransaction[i].amount;
        }
      }
      return {"day": DateFormat.E().format(day), "amount": totalSum};
    }).reversed.toList();
  }

  double get maxSpending {
    return transactionForWeek.fold(0, (previousValue, element) {
      return previousValue + element["amount"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ...transactionForWeek.map((val) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                    val["amount"],
                    val["day"],
                    maxSpending == 0.0
                        ? 0
                        : (val["amount"] as double) / maxSpending),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
