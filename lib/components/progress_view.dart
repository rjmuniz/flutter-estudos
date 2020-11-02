import 'package:bytebank_app/components/progress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressView extends StatelessWidget {
  final String message;

  ProgressView({this.message = 'Sending...'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Processing...')),
      body: Progress(message: this.message),
    );
  }
}
