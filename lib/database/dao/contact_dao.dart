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
  static const String _idColumn = 'id';
  static const String _nameColumn = 'name';
  static const String _accountNumberColumn = 'account_number';

  Future<int> save(Contact contact) async {
    debugPrint('saving contact');
    final Database db = await getDatabase();

    Map<String, dynamic> contactMap = _toMap(contact);

    return db.insert(_tableName, contactMap);
  }

  Future<int> update(Contact contact) async {
    debugPrint('updating contact');
    final Database db = await getDatabase();

    Map<String, dynamic> contactMap = _toMap(contact);

    return db.update(
      _tableName,
      contactMap,
      where: 'id = ?',
      whereArgs: [contact.id],
    );
  }

  Future<int> delete(Contact contact) async {
    debugPrint('updating contact');
    final Database db = await getDatabase();

    return db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [contact.id],
    );
  }

  Future<List<Contact>> findAll() async {
    final Database db = await getDatabase();
    await Future.delayed(Duration(seconds: 1));
    return _toList(await db.query(_tableName));
  }


  Map<String, dynamic> _toMap(Contact contact) {
    final Map<String, dynamic> contactMap = Map();
    //contactMap[_idColumn] = contact.id; //incrementado automaticamente
    contactMap[_nameColumn] = contact.fullName;
    contactMap[_accountNumberColumn] = contact.accountNumber;
    return contactMap;
  }


  Future<Contact> findOne(int id) async {
    final Database db = await getDatabase();

    var items = _toList(await db.query(_tableName,
        where: 'id = ?',
        whereArgs: [id]));
    return items.first;
  }

  List<Contact> _toList(List<Map<String, dynamic>> resultData) {
    return resultData
        .map((row) => Contact(
              row[_idColumn],
              row[_nameColumn],
              row[_accountNumberColumn],
            ))
        .toList();
  }
}
