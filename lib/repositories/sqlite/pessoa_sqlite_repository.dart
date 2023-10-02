import 'package:calculadora_imc/models/pessoa_sqlite_model.dart';
import 'package:calculadora_imc/repositories/sqlite/sql_database.dart';
import 'package:flutter/material.dart';

class PessoaSQLiteRepository {
  Future<List<PessoaSQLiteModel>> obterDados() async {
    List<PessoaSQLiteModel> pessoas = [];
    var db = await SQLiteDataBase().obterDataBase();
    var resultado =
        await db.rawQuery('SELECT id, nome, peso, altura FROM pessoas');

    for (var elemento in resultado) {
      pessoas.add(PessoaSQLiteModel(
          int.parse(elemento['id'].toString()),
          elemento['nome'].toString(),
          double.parse(elemento['peso'].toString()),
          double.parse(elemento['altura'].toString())));
    }
    return pessoas;
  }

  Future<int> salvar(PessoaSQLiteModel pessoaSQLiteModel) async {
    var db = await SQLiteDataBase().obterDataBase();
    return  await db.rawInsert(
        'INSERT INTO pessoas (nome, altura, peso) values(?,?,?)', [
      pessoaSQLiteModel.nome,
      pessoaSQLiteModel.altura,
      pessoaSQLiteModel.peso
    ]);
  }

  Future<void> remover(int id) async {
    var db = await SQLiteDataBase().obterDataBase();

    await db.rawDelete('DELETE FROM pessoas WHERE id = ?', [id]);
  }

  Future getPessoa(int id) async {
    var db = await SQLiteDataBase().obterDataBase();
    List<Map<String, dynamic>> result = await db.rawQuery(
    'SELECT * FROM pessoas WHERE id = ?',
    [id],
  );

    if (result.isNotEmpty) {
     // return PessoaSQLiteModel.fromMap(result.first);
     return result.first;
    } else {
      //return PessoaSQLiteModel.vazio();
      return null;
    }
  }

  Future<void> atualizar(PessoaSQLiteModel pessoaSQLiteModel) async {
    var db = await SQLiteDataBase().obterDataBase();

    await db.rawInsert('UPDATE pessoas SET nome = ?, peso = ? WHERE altura = ?', [
      pessoaSQLiteModel.nome,
      pessoaSQLiteModel.peso,
      pessoaSQLiteModel.altura
    ]);
  }
}
