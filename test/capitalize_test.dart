import 'package:flutter_test/flutter_test.dart';
import 'package:calculadora_imc/utils/utils_string.dart' as util_str;

void main() {
  test('Teste de validação mudar primeira letra para maiuscula', () {
    final result = util_str.primeiraLetraMaiuscula('nome');
    expect(result, 'Nome');
  });

  test('Teste de validação mudar primeira letra para maiuscula nome e sobrenome', () {
    final result = util_str.primeiraLetraMaiusculaDasPalavras('nome Digitado com sobrenome');
    expect(result, 'Nome Digitado Com Sobrenome');
  });
}
