import 'package:calculadora_imc/models/pessoa.dart';
import 'package:flutter/material.dart';
import 'package:calculadora_imc/imc_functions.dart' as imc;
import 'package:calculadora_imc/validators.dart' as validator;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de IMC',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Calculadora de IMC'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Controladores
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController pesoController = TextEditingController();
  final TextEditingController alturaController = TextEditingController();
  Pessoa? pessoa;

  // GlobalKey para controlar o estado do formulário
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nomeController.dispose();
    pesoController.dispose();
    alturaController.dispose();
    super.dispose();
  }

  setDadosPessoa() {
    // Validar o formulário antes de prosseguir
    if (_formKey.currentState!.validate()) {
      String nome = nomeController.text;
      double? peso = validator.parseDouble(pesoController.text);
      double? altura = validator.parseDouble(alturaController.text);

      if (peso != null && altura != null) {
        setState(() {
          pessoa = Pessoa(nome, peso, altura, imc.calculaImc(peso, altura));
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ElevatedButton buildCalcularIMCButton() {
      return ElevatedButton(
        onPressed: setDadosPessoa,
        child: const Text('Calcular IMC'),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: pessoa != null
            ? Column(
                children: [
                  Text(
                      '${pessoa!.getNome()} seu IMC é: ${pessoa!.getImcDuasCasasDecimais()}'),
                  Text(
                      'Classificação: ${imc.classificacaoImc(pessoa!.getImc())}'),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        pessoa = null;
                        nomeController.clear();
                        pesoController.clear();
                        alturaController.clear();
                      });
                    },
                    child: const Text('Calcular IMC Novamente'),
                  ),
                ],
              )
            : SingleChildScrollView(
                child: Form(
                  key: _formKey, // Atribui a chave do formulário
                  /*autovalidateMode: AutovalidateMode
                      .onUserInteraction,*/ // Exibe as mensagens de erro automaticamente
                  child: Column(
                    children: [
                      TextFormField(
                        key: const Key('nome_input_key'),
                        controller: nomeController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: const InputDecoration(
                          labelText: 'Nome',
                        ),
                        validator: validator.validateNome,
                      ),
                      TextFormField(
                        key: const Key('peso_input_key'),
                        controller: pesoController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration:
                            const InputDecoration(labelText: 'Peso (kg)'),
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true, // Permite números decimais
                        ),
                        validator: validator.validatePeso,
                      ),
                      TextFormField(
                        key: const Key('altura_input_key'),
                        controller: alturaController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration:
                            const InputDecoration(labelText: 'Altura (m)'),
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true, // Permite números decimais
                        ),
                        validator: validator.validateAltura,
                      ),
                      const SizedBox(height: 20),
                      buildCalcularIMCButton(),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
