import 'package:bytebank_app/components/response_dialog.dart';
import 'package:flutter/material.dart';

class FailureDialog extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;

  const FailureDialog(this.message,
      {this.title = "Failure", this.icon = Icons.warning});

  @override
  Widget build(BuildContext context) {
    return ResponseDialog(
      title: this.title,
      message: this.message,
      icon: this.icon,
      colorIcon: Colors.red,
    );
  }
}