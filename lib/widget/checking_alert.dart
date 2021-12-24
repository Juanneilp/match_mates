import 'package:flutter/material.dart';
import 'package:match_mates/pages/bottom_nav.dart';

showCheckingAlertDialog(BuildContext context) {
  // set up the AlertDialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Warning"),
        content: Text(
            "Your chat session will ended if you agree with this, are you sure will exit?"),
        actions: [
          TextButton(
            child: Text("No"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text("Yes"),
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => BottomNavigation(),
              ));
            },
          ),
        ],
      );
    },
  );
}
