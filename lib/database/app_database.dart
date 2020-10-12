import 'package:bytebank_app/models/contact.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String databasePath = join(await getDatabasesPath(), 'bytebank.db');

  return openDatabase(
    databasePath,
    onCreate: _createDatabase,
    version: 1,
  );
}

void _createDatabase(Database db, int version) {
  db.execute('CREATE TABLE contacts('
      'id INTEGER PRIMARY KEY, '
      'name TEXT, '
      'account_number INTEGER)');
}

Future<int> save(Contact contact) async {
  debugPrint('saving contact');
  final Database db = await getDatabase();

  final Map<String, dynamic> contactMap = Map();
  //contactMap['id'] = contact.id; //incrementado automaticamente
  contactMap['name'] = contact.fullName;
  contactMap['account_number'] = contact.accountNumber;

  return db.insert('contacts', contactMap);
}

Future<List<Contact>> findAll() async {
  final List<Contact> contactList = List<Contact>();
  final Database db = await getDatabase();

  final List<Map<String, dynamic>> resultData = await db.query('contacts');
  return resultData
      .map((row) => Contact(
            row['id'],
            row['name'],
            row['account_number'],
          ))
      .toList();
}
