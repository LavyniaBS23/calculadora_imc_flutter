import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:calculadora_imc/main.dart';

void main() {
  testWidgets('Teste de validação de entradas incorretas(vazias)',
      (WidgetTester tester) async {
    final expectedErrorMessages = [
      'Por favor, digite seu nome.',
      'Por favor, digite um valor para o peso.(Ex: 60.7 ou 60,7)',
      'Por favor, digite um valor para a altura.(Ex: 1.60 ou 1,60)',
    ];

    final elements = await configureApp(tester);
    await runTest(tester, '', '', '', expectedErrorMessages, elements);
    /**  OU **/
    await runTestSecond(tester, elements['nomeTextField']!, "");
    await runTestSecond(tester, elements['pesoTextField']!, "");
    await runTestSecond(tester, elements['alturaTextField']!, "");
  });

  testWidgets('Teste de validação de entradas incorretas(zeradas)',
      (WidgetTester tester) async {
    final expectedErrorMessages = [
      'O peso deve ser maior que zero.',
      'A altura deve ser maior que zero.',
    ];

    final elements = await configureApp(tester);
    await runTest(
        tester, 'Nome de teste', '0', '0', expectedErrorMessages, elements);
    await runTestSecond(tester, elements['alturaTextField']!, "Nome de teste");
    await runTestSecond(tester, elements['pesoTextField']!, "Nome de teste");
  });

  testWidgets('Teste de validação de entradas apenas peso vazio',
      (WidgetTester tester) async {
    final expectedErrorMessages = [
      'Por favor, digite um valor para o peso.(Ex: 60.7 ou 60,7)',
    ];

    final elements = await configureApp(tester);
    await runTest(
        tester, 'Nome de teste', '', '1.75', expectedErrorMessages, elements);
    await runTestSecond(tester, elements['pesoTextField']!, "Nome de teste");
  });

  testWidgets('Teste de validação de entradas apenas altura vazio',
      (WidgetTester tester) async {
    final expectedErrorMessages = [
      'Por favor, digite um valor para a altura.(Ex: 1.60 ou 1,60)',
    ];
    final elements = await configureApp(tester);
    await runTest(
        tester, 'Nome de teste', '70.5', '', expectedErrorMessages, elements);
    await runTestSecond(tester, elements['alturaTextField']!, "Nome de teste");
  });

  testWidgets('Teste de validação de entradas apenas altura zerada',
      (WidgetTester tester) async {
    final expectedErrorMessages = [
      'A altura deve ser maior que zero.',
    ];

    final elements = await configureApp(tester);
    await runTest(
        tester, 'Nome de teste', '70.5', '0', expectedErrorMessages, elements);
    await runTestSecond(tester, elements['alturaTextField']!, "Nome de teste");
  });

  testWidgets('Teste de validação de entradas apenas peso zerado',
      (WidgetTester tester) async {
    final expectedErrorMessages = [
      'O peso deve ser maior que zero.',
    ];
    final elements = await configureApp(tester);
    await runTest(
        tester, 'Nome de teste', '0', '1.75', expectedErrorMessages, elements);
    await runTestSecond(tester, elements['pesoTextField']!, "Nome de teste");
  });

  testWidgets('Teste de validação de entradas corretas',
      (WidgetTester tester) async {
    final elements = await configureApp(tester);
    await runTest(tester, 'Nome de teste', '70.5', '1.75', [], elements);
  });

  testWidgets('Teste de validação de entradas inválidas',
      (WidgetTester tester) async {
    final expectedErrorMessages = [
      'O valor digitado para o peso não é um número válido.',
      'O valor digitado para a altura não é um número válido.',
    ];
    final elements = await configureApp(tester);
    await runTest(tester, 'Nome de teste', 'teste_peso', 'teste_altura',
        expectedErrorMessages, elements);
    await runTestSecond(tester, elements['pesoTextField']!, "Nome de teste");
    await runTestSecond(tester, elements['alturaTextField']!, "Nome de teste");
  });
}

Future<Map<String, Finder>> configureApp(WidgetTester tester) async {
  await tester.pumpWidget(const MyApp());

  // Encontre os widgets TextFormField pela Key
  final pesoTextField = find.byKey(const Key('peso_input_key'));
  final alturaTextField = find.byKey(const Key('altura_input_key'));
  final nomeTextField = find.byKey(const Key('nome_input_key'));
  final calcularButton = find.text('Calcular IMC');

  return {
    'pesoTextField': pesoTextField,
    'alturaTextField': alturaTextField,
    'nomeTextField': nomeTextField,
    'calcularButton': calcularButton,
  };
}

Future<void> runTest(
    WidgetTester tester,
    String nome,
    String peso,
    String altura,
    List<String> expectedErrorMessages,
    Map<String, Finder> elements) async {
  await tester.enterText(elements['nomeTextField']!, nome);
  await tester.enterText(elements['pesoTextField']!, peso);
  await tester.enterText(elements['alturaTextField']!, altura);

  await tester.tap(elements['calcularButton']!);
  await tester.pump();

  for (final errorMessage in expectedErrorMessages) {
    expect(find.text(errorMessage), findsOneWidget);
  }
  //se as entradas forem corretas
  if (expectedErrorMessages.isEmpty) {
    expect(find.text('Nome De Teste seu IMC é: 23.02'), findsOneWidget);
  }
}

Future<void> runTestSecond(
    WidgetTester tester, Finder field, String nome) async {
  // Verifique se o resultado NÃO está visível na tela
  expect(find.text("$nome seu IMC é:"), findsNothing);

  expect(
    find.descendant(
      of: field,
      matching: find.byWidgetPredicate((Widget widget) {
        return widget is InputDecorator && widget.decoration.errorText != null;
      }),
    ),
    findsOneWidget,
  ); // Verifica se o campo está destacado
}
