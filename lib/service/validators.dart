import 'package:calculadora_imc/utils/utils_double.dart' as util_double;
class Validators {
  String? validateNome(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, digite seu nome.';
    }
    return null; // Retorna null quando a validação passa
  }

  String? validatePeso(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, digite um valor para o peso.(Ex: 60.7 ou 60,7)';
    }
    double? peso = util_double.parseDouble(value);
    if (peso == null) {
      return 'O valor digitado para o peso não é um número válido.';
    }
    if (peso <= 0) {
      return 'O peso deve ser maior que zero.';
    }
    return null; // Retorna null quando a validação passa
  }

  String? validateAltura(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, digite um valor para a altura.(Ex: 1.60 ou 1,60)';
    }
    double? altura = util_double.parseDouble(value);
    if (altura == null) {
      return 'O valor digitado para a altura não é um número válido.';
    }
    if (altura <= 0) {
      return 'A altura deve ser maior que zero.';
    }
    return null; // Retorna null quando a validação passa
  }
}
