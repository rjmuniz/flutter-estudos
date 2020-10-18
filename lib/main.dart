import 'package:bytebank_app/screens/Dashboard.dart';
import 'package:bytebank_app/screens/contact_form.dart';
import 'package:bytebank_app/screens/contacts_list.dart';
import 'package:bytebank_app/screens/transaction_form.dart';
import 'package:bytebank_app/screens/transactions_list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(BytebankApp());
}

class BytebankApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: Dashboard.route,
        routes: {
          Dashboard.route: (context) => Dashboard(),
          ContactsList.route: (context) => ContactsList(),
          ContactForm.route: (context) => ContactForm(),
          TransactionList.route: (context) => TransactionList(),
          TransactionForm.route: (context) => TransactionForm(),
        },
        theme: ThemeData(
            primaryColor: Colors.green[900],
            accentColor: Colors.blueAccent[700],
            buttonTheme: ButtonThemeData(
              buttonColor: Colors.blueAccent[700],
              textTheme: ButtonTextTheme.primary,
            )),
        home: Dashboard());
  }
}
