import 'package:bytebank_app/dao/contact_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String databasePath = join(await getDatabasesPath(), 'bytebank.db');

  return openDatabase(
    databasePath,
    onCreate: _createDatabase,
    version: 1,
   // onDowngrade: onDatabaseDowngradeDelete
  );
}

void _createDatabase(Database db, int version) {
  db.execute(ContactDao.tableSql);
}


