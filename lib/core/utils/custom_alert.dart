import 'package:flutter/material.dart';

class CustomAlertBox {
  Future<dynamic> buildShowDialog(BuildContext context, String alertHeader,
      String alertTitle, String alertSubTitle, String btnText) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(alertHeader),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(alertTitle),
                Text(alertSubTitle),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(btnText),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
