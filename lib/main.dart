import 'package:expense_manager/modal/transactions.dart';
import 'package:expense_manager/widget/add_transaction.dart';
import 'package:expense_manager/widget/chart.dart';
import 'package:expense_manager/widget/transaction_list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Expense Manager App',
        home: MyHomePage(),
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.yellowAccent,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
              )),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                      headline6: TextStyle(
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ))),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> transactions = [
    // Transaction(id: 1, amount: 70.65, time: DateTime.now(), title: "Shoes"),
    // Transaction(id: 2, amount: 45.45, time: DateTime.now(), title: "Shirt"),
    // Transaction(id: 3, amount: 100.99, time: DateTime.now(), title: "Hat"),
    // Transaction(id: 4, amount: 70.56, time: DateTime.now(), title: "kfc"),
    // Transaction(id: 5, amount: 80.56, time: DateTime.now(), title: "Fuel"),
  ];

  void _addTransaction(TextEditingController titleController,
      TextEditingController amountController) {
    String trxnTitle = titleController.text;
    double trxnAmount = double.parse(amountController.text);
    int trxnId = transactions.length + 1;
    DateTime trxnTime = DateTime.now();

    if (trxnTitle.isEmpty || trxnAmount <= 0) {
      return;
    }
    setState(() {
      transactions.add(Transaction(
          id: trxnId, amount: trxnAmount, time: trxnTime, title: trxnTitle));
    });

    Navigator.of(context).pop();
  }

  void bottomModalSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (bContext) {
          return AddTransaction(_addTransaction);
        });
  }

  List<Transaction> get recentTransaction {
    return transactions.map((trxn) {
      if (trxn.time.isAfter(DateTime.now().subtract(Duration(days: 7)))) {
        return trxn;
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Manager'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => bottomModalSheet(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(recentTransaction),
            TransactionList(transactions),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () => bottomModalSheet(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
