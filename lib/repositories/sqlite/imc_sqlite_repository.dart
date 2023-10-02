import 'package:calculadora_imc/models/imc.dart';
import 'package:calculadora_imc/models/imc_sqlite_model.dart';
import 'package:calculadora_imc/repositories/sqlite/sql_database.dart';

class ImcSQLiteRepository {

  Future<List> obterDados() async {
    List imcsPessoas = [];
    var db = await SQLiteDataBase().obterDataBase();
    var result = await db.rawQuery(
        //apenasMeus ? 'SELECT id, pessoa_id, imc FROM imc WHERE id = 0' :
        'SELECT imcs.id, imcs.pessoa_id, imcs.imc, pessoas.nome, pessoas.altura, pessoas.peso FROM imcs JOIN pessoas ON imcs.pessoa_id = pessoas.id');

    for (var element in result) {
      imcsPessoas.add({
        'id': int.parse(element['id'].toString()),
        'nome': element['nome'].toString(),
        'altura': double.parse(element['altura'].toString()),
        'peso': double.parse(element['peso'].toString()),
        'imc': double.parse(element['imc'].toString()),
      });
    }
    return imcsPessoas;
  }

  Future<void> salvar(ImcSQLiteModel imcSQLiteModel) async {
    var db = await SQLiteDataBase().obterDataBase();

    await db.rawInsert('INSERT INTO imcs (pessoa_id, imc) values(?,?)',
        [imcSQLiteModel.pessoaId, imcSQLiteModel.imc]);
  }


  Future<void> remover(int id) async {
    var db = await SQLiteDataBase().obterDataBase();

    await db.rawDelete('DELETE FROM imcs WHERE id = ?', [id]);
  }
  
}
