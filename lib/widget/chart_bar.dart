import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String _day;
  final double _amount;
  final double _percentSpend;

  ChartBar(this._amount, this._day, this._percentSpend);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          FittedBox(
            child: Text("\$${_amount.toStringAsFixed(0)}"),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: 10,
            height: 60,
            child: Stack(children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              FractionallySizedBox(
                  heightFactor: _percentSpend,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(5),
                      color: Theme.of(context).primaryColor,
                    ),
                  ))
            ]),
          ),
          SizedBox(
            height: 10,
          ),
          Text(_day),
        ],
      ),
    );
  }
}
