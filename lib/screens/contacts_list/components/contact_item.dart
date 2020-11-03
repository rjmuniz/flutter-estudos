
import 'package:bytebank_app/models/contact.dart';
import 'package:flutter/material.dart';

class ContactItem extends StatelessWidget {
  final Contact contact;
  final Function onClick;
  static const editValue = "edit";
  static const deleteValue = "delete";

  ContactItem(this.contact, {@required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: ()=>onClick(),
        title: Text(
          contact.fullName,
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.normal),
        ),
        subtitle: Text(contact.accountNumber.toString(),
            style: TextStyle(fontSize: 16.0)),
      ),
    );
  }
}