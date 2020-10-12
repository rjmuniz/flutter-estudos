import 'package:bytebank_app/database/app_database.dart';
import 'package:bytebank_app/models/contact.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

class ContactDao {
  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_idColumn INTEGER PRIMARY KEY, '
      '$_nameColumn TEXT, '
      '$_accountNumberColumn INTEGER)';

  static const String _tableName = 'contacts';
  static const String _idColumn ='id';
  static const String _nameColumn ='name';
  static const String _accountNumberColumn ='account_number';

  Future<int> save(Contact contact) async {
    debugPrint('saving contact');
    final Database db = await getDatabase();

    Map<String, dynamic> contactMap = _toMap(contact);

    return db.insert(_tableName, contactMap);
  }

  Map<String, dynamic> _toMap(Contact contact) {
    final Map<String, dynamic> contactMap = Map();
    //contactMap[_idColumn] = contact.id; //incrementado automaticamente
    contactMap[_nameColumn] = contact.fullName;
    contactMap[_accountNumberColumn] = contact.accountNumber;
    return contactMap;
  }

  Future<List<Contact>> findAll() async {
    final Database db = await getDatabase();

    return _toList(await db.query(_tableName));
  }

  List<Contact> _toList(List<Map<String, dynamic>> resultData)  {
    return resultData
        .map((row) => Contact(
              row[_idColumn],
              row[_nameColumn],
              row[_accountNumberColumn],
            ))
        .toList();
  }
}
