import "dart:io";

import 'package:expense_manager/widget/adaptive_Flatbutton.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:intl/intl.dart';

class AddTransaction extends StatefulWidget {
  final Function addtrxn;

  AddTransaction(this.addtrxn);

  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime _selectedDate;

  void datePicker(BuildContext ctx) {
    showDatePicker(
            context: ctx,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((value) {
      if (value != null) {
        setState(() {
          _selectedDate = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: "Item name",
                ),
                controller: titleController,
                onSubmitted: (_) => widget.addtrxn(
                    titleController, amountController, _selectedDate),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Amount",
                ),
                controller: amountController,
                onSubmitted: (_) => widget.addtrxn(
                    titleController, amountController, _selectedDate),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _selectedDate != null
                      ? Text(
                          DateFormat.yMMMd().format(_selectedDate),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      : Text(
                          "*No date selected yet!",
                          style: TextStyle(
                            color: Theme.of(context).errorColor,
                          ),
                        ),
                  AdaptiveFlatButton(datePicker, "Choose Date"),
                ],
              ),
              RaisedButton(
                textColor: Colors.white,
                child: Text("Add Transaction"),
                color: Colors.purple,
                onPressed: () => widget.addtrxn(
                    titleController, amountController, _selectedDate),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
