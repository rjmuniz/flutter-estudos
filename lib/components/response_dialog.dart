import 'package:flutter/material.dart';

class ResponseDialog extends StatelessWidget {
  final String title;
  final String message;
  final String buttonText;
  final IconData icon;
  final Color colorIcon;

  const ResponseDialog({
    this.title = "",
    this.message = "",
    this.buttonText = "Ok",
    this.icon = Icons.info,
    this.colorIcon = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Visibility(
        child: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        visible: title.isNotEmpty,
      ),
      content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Visibility(
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Icon(
                  this.icon,
                  color: colorIcon,
                  size: 64,
                ),
              ),
              visible: this.icon != null,
            ),
            Visibility(
              child: Padding(
                padding: const EdgeInsets.only(top:16.0),
                child: Text(
                  this.message,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24),
                ),
              ),
              visible: this.message.isNotEmpty,
            ),
          ]),
      actions: [
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text(buttonText),
        )
      ],
    );
  }
}
