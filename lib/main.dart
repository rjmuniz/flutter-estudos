import 'package:bytebank_app/database/app_database.dart';
import 'package:bytebank_app/models/contact.dart';
import 'package:bytebank_app/screens/Dashboard.dart';
import 'package:bytebank_app/screens/contact_form.dart';
import 'package:bytebank_app/screens/contacts_list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(BytebankApp());
  // findAll().then((contacts) => debugPrint(contacts.toString()));
  // save(Contact(0, 'asdf', 1234)).then((id) {
  //   debugPrint(id.toString());
  //   // findAll().then((contacts) => debugPrint(contacts.toString()));
  //   findAll().then((lista) => lista.forEach((element) {
  //         debugPrint(element.toString());
  //       }));
  // });
}

class BytebankApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
