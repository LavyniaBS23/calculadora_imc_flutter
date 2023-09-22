import 'package:calculadora_imc/repositories/imc_repository.dart';
import 'package:calculadora_imc/utils/unique_id_generator.dart';

class Imc {
  int _id = 0;
  int _pessoaId = 0;
  double _imc = 0;
  String _nome = "";

  Imc(int pessoaId, double imc, String nome) {
    _pessoaId = pessoaId;
    _imc = imc;
    _nome = nome;
    _id = UniqueIdGenerator.generateUniqueId(ImcRepository().retornaIds());
  }

  int get id => _id;

  String get nome => _nome;

  int get pessoaId => _pessoaId;

  set pessoaId(pessoaId) {
    _pessoaId = pessoaId;
  }

  double get imc => _imc;

  set imc(imc) {
    _imc = imc;
  }

  
   @override
  String toString() {
    return {
      "imc": _imc,
      "Pessoa Id": _pessoaId,
      "nome": _nome,
      "Id": _id,
    }.toString();
  }
}
