import "dart:io";
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final String text;
  final Function handler;

  AdaptiveFlatButton(this.handler, this.text);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: () => handler(context),
            child: Text("Choose Date"),
          )
        : FlatButton(
            onPressed: () => handler(context),
            child: Text("Choose Date"),
            color: Theme.of(context).accentColor,
          );
  }
}
