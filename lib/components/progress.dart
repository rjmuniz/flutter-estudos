import 'package:flutter/material.dart';

class Progress extends StatelessWidget {
  final String message;
  final bool showLoading;

  Progress({this.message = 'Loading...', this.showLoading = true});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          showLoading ? CircularProgressIndicator() : Icon(Icons.warning),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              message,
              style: TextStyle(fontSize: 24.0),
            ),
          )
        ],
      ),
    );
  }
}
