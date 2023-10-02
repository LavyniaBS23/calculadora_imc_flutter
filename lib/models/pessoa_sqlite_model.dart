import 'package:calculadora_imc/utils/utils_string.dart' as util_str;

class PessoaSQLiteModel {
  int _id = 0;
  double _peso = 0;
  double _altura = 0;
  String _nome = "";

  //construtor
  PessoaSQLiteModel(this._id, this._nome, this._peso, this._altura);

  PessoaSQLiteModel.fromMap(map) {
    _id = map['id'];
    _nome = map['nome'];
    _peso = double.parse(map['peso']);
    _altura = double.parse(map['altura']);
  }

  PessoaSQLiteModel.vazio() {
    _id = 0;
    _nome = "";
    _peso = 0;
    _altura = 0;
  }

  int get id => _id;

  String get nome => _nome;

  double get altura => _altura;

  double get peso => _peso;

  String getNome() {
    
    if (_nome.contains(' ')) {
      return util_str.primeiraLetraMaiusculaDasPalavras(_nome);
    }
    return util_str.primeiraLetraMaiuscula(_nome);
  }

  set peso(double peso) {
    _peso = peso;
  }

  set nome(String nome) {
    _nome = nome;
  }

  set altura(double altura) {
    _altura = altura;
  }
}
