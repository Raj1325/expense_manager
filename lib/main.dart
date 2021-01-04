import 'package:flutter/material.dart';
import './transactions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  List<Transaction> transaction = [
    Transaction(id: 1, amount: 70, time: DateTime.now(), title: "Shoes"),
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
              Card(
                child: Text("Expenses"),
                elevation: 5,
              ),
            ],
          ),
        ));
  }
}
