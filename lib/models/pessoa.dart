import 'package:calculadora_imc/utils/utils_string.dart' as util_str;

class Pessoa {
  double _peso = 0.00;
  double _altura = 0.00;
  String _nome = "";
  double _imc = 0.00;

  //construtor
  Pessoa(String nome, double peso, double altura, double imc) {
    _nome = nome;
    _peso = peso;
    _altura = altura;
    _imc = imc;
  }

  void setImc(imc) {
    _imc = imc;
  }

  double getImc() {
    return _imc;
  }

  //exibição
  String getImcDuasCasasDecimais() {
    return _imc.toStringAsFixed(2); // "22.46"
    /*(double valorFormatado = (valor * math.pow(10, 2)).round() / math.pow(10, 2))*/
  }

  //sobrescrita
  @override
  String toString() {
    return {
      "Nome": _nome,
      "Peso": _peso,
      "Altura": _altura,
      "IMC": _imc,
    }.toString();
  }

  void setNome(String nome) {
    _nome = nome;
  }

  String getNome() {
    if (_nome.contains(' ')) {
      return util_str.primeiraLetraMaiusculaDasPalavras(_nome);
    }
    return util_str.primeiraLetraMaiuscula(_nome);
  }

  void setPeso(double peso) {
    _peso = peso;
  }

  double getPeso() {
    return _peso;
  }

  void setAltura(double altura) {
    _altura = altura;
  }

  double getAltura() {
    return _altura;
  }
}
