import 'package:calculadora_imc/repositories/pessoa_repository.dart';
import 'package:calculadora_imc/utils/unique_id_generator.dart';
import 'package:calculadora_imc/utils/utils_string.dart' as util_str;

class Pessoa {
  int _id = 0;
  double _peso = 0.00;
  double _altura = 0.00;
  String _nome = "";

  //construtor
  Pessoa(String nome, double peso, double altura) {
    _nome = nome;
    _peso = peso;
    _altura = altura;
    _id = UniqueIdGenerator.generateUniqueId(PessoaRepository().retornaIds());
  }

  int get id => _id;

  //sobrescrita
  @override
  String toString() {
    return {
      "Nome": _nome,
      "Peso": _peso,
      "Altura": _altura,
      "Id": _id,
    }.toString();
  }

  set nome(String nome) {
    _nome = nome;
  }

  String getNome() {
    if (_nome.contains(' ')) {
      return util_str.primeiraLetraMaiusculaDasPalavras(_nome);
    }
    return util_str.primeiraLetraMaiuscula(_nome);
  }

  set peso(double peso) {
    _peso = peso;
  }

  double get peso => _peso;

  set altura(double altura) {
    _altura = altura;
  }

  double get altura => _altura;

}
