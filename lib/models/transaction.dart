import 'dart:convert';

import 'package:bytebank_app/models/contact.dart';

class Transaction {
  final double value;
  final Contact contact;

  static const String _contactField = 'contact';
  static const String _valueField = 'value';

  Transaction(this.value, this.contact);

  @override
  String toString() {
    return 'Transaction{$_valueField: $value, $_contactField: $contact}';
  }

  Transaction.fromJson(Map<String, dynamic> json)
      : value = json[_valueField],
        contact = Contact.fromJson(json[_contactField]);

  Map<String, dynamic> toJson() => {
        _valueField: this.value,
        _contactField: this.contact.toJson()
      };
}
