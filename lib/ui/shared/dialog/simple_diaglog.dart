import 'package:flutter/material.dart';

Future<void> showSimpleDialog(BuildContext context, String title,
    String message, Widget actionWidget) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(message),
            ],
          ),
        ),
        actions: <Widget>[
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: actionWidget,
          )
        ],
      );
    },
  );
}
