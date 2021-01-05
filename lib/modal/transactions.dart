import "package:flutter/foundation.dart";

class Transaction {
  int id;
  String title;
  double amount;
  DateTime time;

  Transaction(
      {@required this.id,
      @required this.amount,
      @required this.time,
      @required this.title});
}
