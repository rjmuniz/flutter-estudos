import 'dart:ui';

import 'package:bytebank_app/dao/contact_dao.dart';
import 'package:bytebank_app/models/contact.dart';
import 'package:flutter/material.dart';

class ContactFormArguments {
  final int id;

  ContactFormArguments(this.id);

  @override
  String toString() {
    return 'ContactFormArguments{id: $id}';
  }
}

class ContactForm extends StatefulWidget {
  static const String route = '/contact_form';

  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();
  final ContactDao _dao = ContactDao();

  @override
  Widget build(BuildContext context) {
    final ContactFormArguments args = ModalRoute.of(context).settings.arguments;
    if (args != null) {
      _dao.findOne(args.id).then((contact) {
        _idController.text = contact.id.toString();
        _fullNameController.text = contact.fullName;
        _accountNumberController.text = contact.accountNumber.toString();
      });
    } else
      _idController.text = 0.toString();
    return Scaffold(
      appBar: AppBar(title: Text('New contact')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _fullNameController,
              decoration: InputDecoration(
                  hintText: 'Fulano da Silva', labelText: 'Full name'),
              style: TextStyle(fontSize: 24.0),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextField(
                controller: _accountNumberController,
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
                    final int id = int.tryParse(_idController.text);
                    final String fullname = _fullNameController.text;
                    final int accountNumber =
                        int.tryParse(_accountNumberController.text);
                    final Contact newContact =
                        Contact(id, fullname, accountNumber);
                    if(newContact.id == 0)
                    _dao.save(newContact).then((id) => Navigator.pop(context));
                    else
                      _dao.update(newContact).then((id) => Navigator.pop(context));
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
