import 'dart:ui';

import 'package:bytebank_app/dao/contact_dao.dart';
import 'package:bytebank_app/models/contact.dart';
import 'package:flutter/material.dart';

class ContactForm extends StatefulWidget {
  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController _fullNamecontroller = TextEditingController();
  final TextEditingController _accountNumbercontroller =
      TextEditingController();
  final ContactDao _dao = ContactDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New contact')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _fullNamecontroller,
              decoration: InputDecoration(
                  hintText: 'Fulano da Silva', labelText: 'Full name'),
              style: TextStyle(fontSize: 24.0),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextField(
                controller: _accountNumbercontroller,
                decoration: InputDecoration(
                    hintText: '1000', labelText: 'Account number'),
                keyboardType: TextInputType.number,
                style: TextStyle(fontSize: 24),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: RaisedButton(
                  child: Text('Create'),
                  onPressed: () {
                    final String fullname = _fullNamecontroller.text;
                    final int accountNumber =
                        int.tryParse(_accountNumbercontroller.text);
                    final Contact newContact =
                        Contact(0, fullname, accountNumber);

                    _dao.save(newContact).then((id) => Navigator.pop(context));
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
