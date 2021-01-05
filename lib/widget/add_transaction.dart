import "package:flutter/material.dart";

class AddTransaction extends StatefulWidget {
  final Function addtrxn;

  AddTransaction(this.addtrxn);

  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: "Item name",
              ),
              controller: titleController,
              onSubmitted: (_) =>
                  widget.addtrxn(titleController, amountController),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "Amount",
              ),
              controller: amountController,
              onSubmitted: (_) =>
                  widget.addtrxn(titleController, amountController),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            RaisedButton(
              child: Text("Add Transaction"),
              color: Colors.purple,
              onPressed: () =>
                  widget.addtrxn(titleController, amountController),
            ),
          ],
        ),
      ),
    );
  }
}
