import "dart:io";

import 'package:expense_manager/modal/transactions.dart';
import 'package:expense_manager/widget/add_transaction.dart';
import 'package:expense_manager/widget/chart.dart';
import 'package:expense_manager/widget/transaction_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
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
          accentColor: Colors.purpleAccent,
          errorColor: Colors.red,
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

  bool _switch = false;

  void _addTransaction(TextEditingController titleController,
      TextEditingController amountController, DateTime date) {
    String trxnTitle = titleController.text;
    double trxnAmount = double.parse(amountController.text);
    String trxnId = DateTime.now().toString();

    if (trxnTitle.isEmpty || trxnAmount <= 0 || date == null) {
      return;
    }
    setState(() {
      transactions.add(Transaction(
          id: trxnId, amount: trxnAmount, time: date, title: trxnTitle));
    });

    Navigator.of(context).pop();
  }

  void deletTransaction(String trxnStamp) {
    setState(() {
      transactions.removeWhere((element) => trxnStamp == element.id);
    });
  }

  void bottomModalSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (bContext) {
          return AddTransaction(_addTransaction);
        });
  }

  List<Transaction> get recentTransaction {
    return transactions.where((element) {
      return element.time.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context);
    final isLandscape = mediaquery.orientation == Orientation.landscape;
    final PreferredSizeWidget appbar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Expense Manager'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () => bottomModalSheet(context),
                  child: Icon(CupertinoIcons.add),
                ),
              ],
            ),
          )
        : AppBar(
            title: Text('Expense Manager'),
            actions: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => bottomModalSheet(context),
              )
            ],
          );
    final transactionWidget = Container(
      height: (mediaquery.size.height -
              appbar.preferredSize.height -
              mediaquery.padding.top) *
          0.7,
      child: TransactionList(transactions, deletTransaction),
    );

    final pageBody = SafeArea(
        child: SingleChildScrollView(
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (isLandscape)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Show chart",
                  style: Theme.of(context).textTheme.headline6,
                ),
                Switch.adaptive(
                    activeColor: Theme.of(context).accentColor,
                    value: _switch,
                    onChanged: (val) {
                      setState(() {
                        _switch = val;
                      });
                    })
              ],
            ),
          if (!isLandscape)
            Container(
              height: (mediaquery.size.height -
                      appbar.preferredSize.height -
                      mediaquery.padding.top) *
                  0.3,
              child: Chart(recentTransaction),
            ),
          if (!isLandscape) transactionWidget,
          if (isLandscape)
            _switch
                ? Container(
                    height: (mediaquery.size.height -
                            appbar.preferredSize.height -
                            mediaquery.padding.top) *
                        0.7,
                    child: Chart(recentTransaction),
                  )
                : transactionWidget,
        ],
      ),
    ));

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appbar,
          )
        : Scaffold(
            appBar: appbar,
            body: pageBody,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(
                      Icons.add,
                    ),
                    onPressed: () => bottomModalSheet(context),
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
