import 'package:bytebank_app/models/contact.dart';

const String _idField = 'id';
const String _contactField = 'contact';
const String _valueField = 'value';

class Transaction {
  final String id;
  final double value;
  final Contact contact;

  Transaction(this.id, this.value, this.contact) ;

  @override
  String toString() {
    return 'Transaction{$_idField: $id, $_valueField: $value, $_contactField: $contact}';
  }

  Transaction.fromJson(Map<String, dynamic> json)
      : id = json[_idField],
        value = json[_valueField],
        contact = Contact.fromJson(json[_contactField]);

  Map<String, dynamic> toJson() => {
        _idField: this.id,
        _valueField: this.value,
        _contactField: this.contact.toJson()
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Transaction &&
          runtimeType == other.runtimeType &&
          value == other.value &&
          contact == other.contact;

  @override
  int get hashCode => value.hashCode ^ contact.hashCode;
}
