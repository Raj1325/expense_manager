import 'package:flutter/material.dart';
import './transactions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  List<Transaction> transactions = [
    Transaction(id: 1, amount: 70.65, time: DateTime.now(), title: "Shoes"),
    Transaction(id: 2, amount: 45.45, time: DateTime.now(), title: "Shirt"),
    Transaction(id: 3, amount: 100.99, time: DateTime.now(), title: "Hat"),
    Transaction(id: 4, amount: 70.56, time: DateTime.now(), title: "kfc"),
    Transaction(id: 5, amount: 80.56, time: DateTime.now(), title: "Fuel"),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Expense Manager App',
        home: Scaffold(
          appBar: AppBar(title: Text('Expense Manager')),
          body: Column(
            children: [
              Container(
                child: Card(
                  child: Text("Chart"),
                  elevation: 5,
                ),
                width: double.infinity,
              ),
              ...transactions.map((trxn) {
                Card(
                  child: Text(trxn.title),
                );
              }).toList(),
            ],
          ),
        ));
  }
}
