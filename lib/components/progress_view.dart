import 'package:bytebank_app/components/progress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Processing...')),
      body: Progress(message: 'Sending...'),
    );
  }
}
