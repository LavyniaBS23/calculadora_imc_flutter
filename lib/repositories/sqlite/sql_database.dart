import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class SQLiteDataBase {
  static Database? db;

  Future<Database> obterDataBase() async {
    if(db == null){
      return await iniciarBancoDeDados();
    }
    return db!;
  }
  Future<Database> iniciarBancoDeDados() async {
    var db = await openDatabase(
        path.join(await getDatabasesPath(), 'database.db'),
        version: 1,
        onCreate: (Database db, int version) async {
              await db.execute('CREATE TABLE pessoas(id INTEGER PRIMARY KEY AUTOINCREMENT,nome TEXT,altura DECIMAL, peso DECIMAL)');
               await db.execute('CREATE TABLE imcs(id INTEGER PRIMARY KEY AUTOINCREMENT, pessoa_id INTEGER, imc DECIMAL,created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, FOREIGN KEY (pessoa_id) REFERENCES pessoas(id))');
        },
        onUpgrade: (Database db, int oldVersion, int newVersion) async {
          
        }
    );
    return db;
  }
}
