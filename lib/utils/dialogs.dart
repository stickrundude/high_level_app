import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '/generated/l10n.dart';

Future<bool?> showUpgradeDialog(BuildContext context,
    {required Function onPayPressed}) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(S.of(context).upgradeRequiredTitle),
        content: Text(S.of(context).upgradeRequiredMessage),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: Text(S.of(context).cancel),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, true);
              onPayPressed();
            },
            child: Text(S.of(context).pay),
          ),
        ],
      );
    },
  );
}

Future<bool?> confirmDeleteNoteDialog(BuildContext context) async {
  return showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(S.of(context).confirmDeletionTitle),
      content: Text(S.of(context).confirmDeletionMessage),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: Text(S.of(context).no),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: Text(S.of(context).yes),
        ),
      ],
    ),
  );
}

void showToast(String message) {
  Fluttertoast.showToast(msg: message);
}
