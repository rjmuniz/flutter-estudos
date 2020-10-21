import 'package:flutter/material.dart';

class TransactionAuthDialog extends StatefulWidget {
  final Function(String password) onConfirm;

  const TransactionAuthDialog({@required this.onConfirm});

  @override
  _TransactionAuthDialogState createState() => _TransactionAuthDialogState();
}

class _TransactionAuthDialogState extends State<TransactionAuthDialog> {
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Authenticate"),
      content: TextField(
        controller: _passwordController,
        decoration: InputDecoration(border: OutlineInputBorder()),
        style: TextStyle(fontSize: 64, letterSpacing: 24),
        maxLength: 4,
        obscureText: true,
        textAlign: TextAlign.center,
        keyboardType:
            TextInputType.numberWithOptions(signed: false, decimal: false),
      ),
      actions: [
        FlatButton(
            onPressed: () => Navigator.pop(context), child: Text("Cancel")),
        FlatButton(
            onPressed: () {
              widget.onConfirm(_passwordController.text);
              Navigator.pop(context);
            },
            child: Text("Confirm"))
      ],
    );
  }
}
