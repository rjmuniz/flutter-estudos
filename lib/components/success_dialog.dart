import 'package:bytebank_app/components/response_dialog.dart';
import 'package:flutter/material.dart';

class SuccessDialog extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;

  const SuccessDialog(this.message,
      {this.title = "Success", this.icon = Icons.done});

  @override
  Widget build(BuildContext context) {
    return ResponseDialog(
      title: this.title,
      message: this.message,
      icon: this.icon,
      colorIcon: Colors.green,
    );
  }
}



