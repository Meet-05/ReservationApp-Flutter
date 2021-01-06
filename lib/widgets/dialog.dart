import 'package:flutter/material.dart';

Future<bool> buildShowDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to permanantely delete this?'),
            actions: [
              FlatButton(
                  child: Text('Yes'),
                  onPressed: () {
                    Navigator.of(ctx).pop(true);
                  }),
              FlatButton(
                  child: Text('No'),
                  onPressed: () {
                    Navigator.of(ctx).pop(false);
                  }),
            ],
          ));
}
