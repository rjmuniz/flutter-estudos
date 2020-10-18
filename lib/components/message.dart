import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  final String message;
  final IconData icon;

  Message( {this.message = 'Loading...',this.icon});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Visibility(
            child: Icon(icon, size: 32.0),
            visible: icon != null,
          ),
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
