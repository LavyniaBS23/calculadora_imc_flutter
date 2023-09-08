import 'package:flutter_test/flutter_test.dart';
import 'package:calculadora_imc/validators.dart' as validator;

void main() {
  group('Validators', () {
    test('Teste de validação nome vazio', () {
      final result = validator.validateNome('');
      expect(result, 'Por favor, digite seu nome.');
    });

    test('Teste de validação peso vazio', () {
      final result = validator.validatePeso('');
      expect(result, 'Por favor, digite um valor para o peso.(Ex: 60.7 ou 60,7)');
    });

    test('Teste de validação peso zerado', () {
      final result = validator.validatePeso('0');
      expect(result, 'O peso deve ser maior que zero.');
    });

    test('Teste de validação altura vazia', () {
      final result = validator.validateAltura('');
      expect(result, 'Por favor, digite um valor para a altura.(Ex: 1.60 ou 1,60)');
    });

    test('Teste de validação altura zerada', () {
      final result = validator.validateAltura('0');
      expect(result, 'A altura deve ser maior que zero.');
    });
  });
}