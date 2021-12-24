import 'package:flutter/material.dart';

showAlertDialog(BuildContext context) {
  // set up the AlertDialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Upcoming Feature"),
        content: Text("Feature will be implemented in future"),
        actions: [
          TextButton(
            child: Text("Ok"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
